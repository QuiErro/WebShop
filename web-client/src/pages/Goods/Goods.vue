<template>
  <div id="container">
			<div class="pro_detail">
				<div class="pro_img">
					<div class="tb_booth">
						<img :src="goodsDetail[0].image_url" class="pro_middle_img" />
					</div>
				</div>
				<div class="pro_meg">
					<div class="pro_meg_hd">
						<h1>
					 		{{goodsDetail[0].goods_name}}
						</h1>
					</div>
					<div class="pro_meg_price">
						<dl>
							<dt>促销价</dt>
							<dd>
								<div class="promo_price">
									<b>￥</b>
									<span class="tm-price">{{goodsDetail[0].price / 100 | priceFormat}}</span>
									<b>优惠促销</b>
								</div>
							</dd>
						</dl>
            <dl>
							<dt>市场价</dt>
							<dd class="nor_price">￥{{goodsDetail[0].normal_price /100 | priceFormat }}</dd>
						</dl>
						<dl>
							<dt>本店优惠</dt>
							<dd>包邮</dd>
						</dl>
            <dl>
							<dt class="sale_tip">{{goodsDetail[0].sales_tip}}</dt>
						</dl>
					</div>
					<div class="pro_meg_deliver">
						<dl>
							<dt>运费</dt>
							<dd>福建福州&nbsp;&nbsp;至&nbsp;&nbsp;福建福州&nbsp;&nbsp;&nbsp;快递:0.00</dd>
						</dl>
					</div>
					<div class="pro_meg_console">
						<dl class="tb-sku">
							<dt>数量</dt>
							<dd>
								<div class="item-amout">
									<el-input-number v-model="shopNum" :min="1" :max="goodsDetail[0].counts"></el-input-number>
								</div>
								<span>库存</span><em>{{goodsDetail[0].counts}}</em><span>件</span>
							</dd>
						</dl>
						<div class="shopping_car">
							<a @click.prevent="dealWithCellBtnClick(goodsDetail[0])">加入购物车</a>
						</div>
					</div>
					<div class="pro_meg_other">
						<dl>
							<dt>服务承诺</dt>
							<dd>
								<span>正品保证</span>
								<span>极速退货</span>
							</dd>
						</dl>
					</div>
				</div>
			</div>
      <div class="pro_comment">
        <h3>商品评价</h3>
        <div v-if="goodsDetail[0].comments_count">
          <div class="media" v-for="(comment, index) in goodsComment" :key="index">
            <div class="media-body">
              <h6 class="media-heading">用户:&nbsp;{{comment.user_name | phoneFormat}}</h6>
              <span>评论:</span>&nbsp;{{comment.comment_detail}}
              <el-rate
                v-model="comment.comment_rating"
                disabled
                show-score
                text-color="#ff9900">
              </el-rate>
            </div>
          </div>
        </div>
        <div class="media" v-else>
          <div class="media-body">
            本商品暂无评论
          </div>
        </div>
      </div>
      <div class="pro_judge" v-if="userInfo.user_phone">
        <h3>评价该商品</h3>
        <span>为该商品评分</span>
        <el-rate
          v-model="rating"
          :colors="colors"
          show-score
          text-color="#ff9900">
        </el-rate>
        <el-input
          type="textarea"
          autosize
          placeholder="请输入内容"
          v-model="textarea">
        </el-input>
        <el-button type="primary" @click="post()">发布<i class="el-icon-edit el-icon--right"></i></el-button>
      </div>
      <div class="pro_judge" v-else>
        <h3>评价该商品</h3>
        <span class="judge_erro_tip">登录后才可发表评论</span>
      </div>
	</div>
</template>

<script>
  import {postComment, addGoodsToCart} from './../../api/index';
  import { MessageBox } from 'element-ui';
  import {mapActions} from 'vuex'
  import {mapState} from 'vuex'

  export default {
    data(){
      return{
        textarea: '',
        rating: 0,
        colors: ['#99A9BF', '#F7BA2A', '#FF9900'],
        currentGoodsId: 0,
        shopNum: 1,
      }
    },
    computed: {
      ...mapState(['goodsDetail','userInfo','goodsComment'])
    },
    created(){
      this.currentGoodsId = Number(this.$route.params.id);
      this.$store.dispatch('reqGoodsDetail', {
          goodsNo: this.currentGoodsId
      });
      this.$store.dispatch('reqGoodsComment', {
          goodsId: this.currentGoodsId
      });
    },
    watch:{
      $route(){
        this.currentGoodsId = Number(this.$route.params.id);
        this.$store.dispatch('reqGoodsDetail', {
          goodsNo: this.currentGoodsId
        });
        this.$store.dispatch('reqGoodsComment', {
          goodsId: this.currentGoodsId
        });
        // 请求当前用户信息
        this.$store.dispatch('getUserInfo');
      }
    },
    filters: {
      phoneFormat(phone) {
        // 1. 转成数组
        let phoneArr = [...phone];
        // 2. 遍历
        let str = '';
        phoneArr.forEach((item, index)=>{
            if(index === 3 || index === 4 ||index === 5 ||index === 6 ){
               str += "*";
            }else {
               str += item;
            }
        });
        return str;
      },
      priceFormat(price) {
        return price.toFixed(2);
      },
    },
    methods:{
      async post(){
        if(!this.textarea){
           MessageBox({
              type: 'info',
              message: "评论不得为空",
			        showClose: true,
           });
           return;
        }
        let result =  await postComment(this.goodsDetail[0].goods_id, this.textarea, this.rating, this.userInfo.user_phone);
        if(result.success_code === 200){
          MessageBox({
              type: 'success',
              message: "发布成功",
			        showClose: true,
          });
          this.textarea = '';
          this.$store.dispatch('reqGoodsComment', {
            goodsId: this.currentGoodsId
          });
        }else{
          MessageBox({
              type: 'info',
              message: "发布失败",
			        showClose: true,
          });
        }
      },
      // 监听商品点击
      async dealWithCellBtnClick(goods){
         // 1. 发送请求
        // user_id, goods_id, goods_name, thumb_url, price, buy_count, counts
        if(this.userInfo.user_phone){
          let result = await addGoodsToCart(this.userInfo.id, goods.goods_id, goods.short_name, goods.thumb_url, goods.price, this.shopNum, goods.counts);
          if(result.success_code === 200){
             MessageBox({
              type: 'success',
              message: result.message,
			        showClose: true,
            });
            let user_id = this.userInfo.id;
            // 请求商品数据
            this.$store.dispatch('reqCartsGoods',{user_id});
            this.shopNum = 1;
          }
        }
      }
    },
  }
</script>

<style scoped>
#container>.pro_detail{
	width: 990px;
  position: relative;
  z-index: 100;
  margin: 20px auto;
}
#container>.pro_comment{
	width: 73%;
  position: relative;
  margin: 20px auto 0;
  padding: 20px;
  border: 1px solid #ccc;
}
#container>.pro_judge{
	width: 73%;
  position: relative;
  margin: 0 auto 20px;
  padding: 20px;
  border-top: none;
  border: 1px solid #ccc;
}
.pro_judge>span{
  font-size: 12px;
  color: #ccc;
}
.pro_judge>.el-rate{
  display: inline-block;
}
.pro_judge .el-textarea{
  width: 50%;
  display: block;
  margin: 20px 0;
}
.pro_comment>h3{
  font-weight: bold;
  margin-bottom: 20px;
}
.pro_comment .media{
  border-top: 1px dashed #ccc;
  padding: 10px 0;
}
.pro_comment .media .media-heading{
  margin-bottom: 10px;
  font-weight: bolder;
}
.pro_comment .media .media-body{
  font-size: 14px;
}
.pro_comment .media .media-body span{
  font-weight: bolder;
}
.pro_comment .el-rate{
  display: inline-block;
  margin-left: 20px;
}
.pro_judge>h3{
  font-weight: bold;
  margin-bottom: 20px;
}
.pro_judge .judge_erro_tip{
  font-size: 15px;
  font-weight: bolder;
  color: #000;
}
.pro_detail>.pro_img{
    float: left;
    width: 460px;
    height: 100%;
    position: relative;
    border: 1px solid #ccc
}
.pro_img>.tb_booth{
	position: relative;
    z-index: 1;
    width: 420px;
    height: 420px;
    margin: 20px auto 0;
}
.tb_booth>.pro_middle_img{
	width: 100%;
	height: 100%;
}
.pro_detail>.pro_meg{
	margin: 0 0 0 520px;
  color: #666;
  padding: 0 0 3px;
}
.pro_meg>.pro_meg_hd{
	padding: 0 10px 12px;
    color: #000;
}
.pro_meg_hd>h1{
    font-size: 16px;
    font-weight: 700;
    color: #000;
}
.pro_meg>.pro_meg_price{
	background-color: #e9e9e9;
    padding: 5px;
}
.pro_meg_price dl{
	padding: 5px;
	display: block;
	margin: 10px 0;
	cursor: pointer;
}
.pro_meg_price dl dt{
	color: #999;
    font-size: 12px;
    text-align: left;
    width: 69px;
    margin: 0 0 0 8px;
    float: left;
}
.pro_meg_price dl dd{
	margin-left: 70px;
    font-family: Arial;
}
.pro_meg_price dl:last-child dd{
	color: #b5621b;
	font-size: 15px;
}
.promo_price{
	line-height: 24px;
    vertical-align: middle;
    color: #FF0036;
    font-size: 18px;
    font-family: Arial;
    -webkit-font-smoothing: antialiased;
}
.promo_price b{
	display: inline-block;
	font-weight: normal;
}
.promo_price b:last-child{
	font-size: 12px;
	background: #f47a86;
	color: white;
	padding: 0 6px;
}
.promo_price>.tm-price{
	font-size: 20px;
	display: inline-block;
	margin-right: 12px;
	font-weight: bold;
}
.nor_price{
  text-decoration: line-through;
}
.sale_tip{
  color: #FF0036 !important;
  font-weight: bolder;
  width: 80px  !important;
}
.pro_meg_deliver{
	margin: 5px 20px 5px 0;
	padding: 5px;
}
.pro_meg_deliver dl{
	padding: 5px;
	font-size: 14px;
	color: black;
	cursor: pointer;
}
.pro_meg_deliver dl dt{
	color: #999;
    font-size: 14px;
    text-align: left;
    width: 69px;
    margin: 0 0 0 8px;
    float: left;
}
.pro_meg_deliver dl dd{
	font-size: 13px;
}
.pro_meg_console{
	margin: 5px 20px 5px 0;
	padding: 5px;
}
.tb-sku{
	padding: 5px;
	font-size: 14px;
	color: black;
	cursor: pointer;
}
.tb-sku dt{
	color: #999;
    font-size: 14px;
    text-align: left;
    width: 69px;
    margin: 0 0 0 8px;
    float: left;
}
.tb-sku dd{
	font-size: 13px;
}
.tb-sku dd div{
	display: inline-block;
	margin-right: 20px;
}
.item-amout{
	height: 25px;
}
.item-amout a{
	display: inline-block;
    height: 23px;
    width: 17px;
    border: 1px solid #e5e5e5;
    background: #f0f0f0;
    text-align: center;
    line-height: 23px;
    color: #444;
    cursor: pointer;
}
.item-amout a:hover{
	color: #f50;
    border-color: #f60;
}
.item-amout>.text_amount{
	width: 40px;
	height: 20px;
	text-align: center;
	display: inline-block;
}
.shopping_car{
	margin: 20px auto 0;
}
.shopping_car>a{
	display: block;
	width: 120px;
	height: 30px;
	background: #FF0036;
	color: white;
	text-align: center;
	line-height: 30px;
	cursor: pointer;
	margin: 0 auto;
}
.pro_meg_other{
	margin: 35px 0;
}
.pro_meg_other dl{
	padding: 5px;
	color: #999;
	cursor: pointer;
	font-size: 12px;
}
.pro_meg_other dl dt{
    font-size: 13px;
    text-align: left;
    width: 69px;
    margin: 0 0 0 8px;
    float: left;
}
.pro_meg_other dl dd span{
	display: inline-block;
	margin-right: 10px;
}
</style>
