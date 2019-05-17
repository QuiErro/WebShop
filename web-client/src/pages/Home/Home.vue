<template>
  <div id="home">
    <div id="container">
			<el-row>
				<!-- 一级菜单 -->
				<el-col :span="4" :offset="1" class="cateList">
					<div class="cate_img">
						<i class="el-icon-office-building"></i>
						商品分类
					</div>
					<el-menu
					  class="el-menu-vertical-demo"
					  background-color="#545c64"
					  text-color="#fff">
					  <el-menu-item index="cate.cate_id" v-for="(cate, index) in categoryList" :key="index" @click="getRList(cate.cate_id)">
						<i :class="cate.cate_icon"></i>
						<span slot="title">{{cate.cate_name}}</span>
					  </el-menu-item>
					</el-menu>
			    </el-col>
			    <!--轮播图-->
				<el-col :span="14">
					<el-carousel v-if="homecasual.length > 0">
					  <el-carousel-item v-for="(casual, index) in homecasual" :key="index">
						<img :src="casual.imgurl" alt="">
					  </el-carousel-item>
					</el-carousel>
				</el-col>
				<!-- 登录信息板块 -->
				<el-col :span="4" class="con_log">
					<div>
						<img src="./img/no_login.jpg"/>
					</div>
					<p>Hi~ 欢迎来到西二商城</p>
					<p v-if="!userInfo.id"><router-link to="/login">登录</router-link><router-link to="/login">注册</router-link></p>
					<p v-else class="userIn"><a>{{ userInfo.user_phone | phoneFormat }},您好</a><router-link to="/me">个人中心</router-link></p>
					<button class="welfare">新人福利</button>
					<button class="vip">加入会员</button>
				</el-col>
			</el-row>

			<!-- 分类产品展示区域 -->
			<div class="product" v-for="(cate, index) in categoryList" :key="index">
				<div class="pro_line">
					<h3>{{ cate.cate_name }}</h3><div><a @click.prevent="getRList(cate.cate_id)">MORE</a></div>
				</div>
				<div class="pro_show">
					<div class="pro" v-for="(pro, index2) in homeshoplist[cate.cate_id - 1]" :key="index2">
						<img v-lazy="pro.thumb_url" class="pro_img">
						<div class="pro_text">
							<p><em>¥{{ pro.price / 100 | priceFormat }}</em></p>
							<p>{{ pro.short_name }}</p>
							<p>西二商城自营店</p>
						</div>
						<div class="add_btn">
							<a @click="goDetail(pro.goods_id)">查看详情</a>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="end_show"></div>

		<!-- 尾部 -->
		<div id="footer">
			<img src="./img/footer.png" />
			<div class="footer_text"></div>
		</div>

		<!--左侧微型购物车区域-->
		<div id="meg">
			<div class="meg_nav">
				<div class="meg_shoppingbag">
					<img src="./img/meg_showcar.png" />
					<p>购物车</p>
					<div><span>0</span></div>
				</div>
				<a href="#" class="meg_top">
					<img src="./img/meg_top.png" />
				</a>
			</div>
			<div class="meg_show">
				<div class="toolbar_header">
					<div class="pro_Chk">
						<input id="pro_ChkAll" type="checkbox">
					</div>
					<label for="pro_ChkAll">全选</label>
					<a href="shoppingBag.html">全屏查看</a>
				</div>
				<div class="meg_content">
					<div class="pro_item">
						<h4 class="item_title">西二商城自营服饰旗舰店<span class="item_one">¥368.00</span></h4>
						<div class="item_content">
							<div class="pro_Chk">
								<input type="checkbox" class="pro_ChkElem">
							</div>
							<div class="item-pic">
								<img src="./img/pro52.jpg"  />
							</div>
							<div class="item-info">万向轮拉杆箱20寸旅行箱</div>
							<div class="item-amout">
								<a class="amout_minus">-</a>
								<input type="text" value="1" class="text_amount" autocomplete="off"/>
								<a class="amout_puls">+</a>
							</div>
							<div class="item-sum"><strong>¥368.00</strong></div>
						</div>
					</div>
					<div class="pro_item">
						<h4 class="item_title">西二商城自营服饰旗舰店<span class="item_one">¥78.00</span></h4>
						<div class="item_content">
							<div class="pro_Chk">
								<input type="checkbox" class="pro_ChkElem">
							</div>
							<div class="item-pic">
								<img src="./img/pro53.jpg"  />
							</div>
							<div class="item-info">冬季加绒高帮帆布鞋</div>
							<div class="item-amout">
								<a class="amout_minus">-</a>
								<input type="text" value="1" class="text_amount" autocomplete="off"/>
								<a class="amout_puls">+</a>
							</div>
							<div class="item-sum"><strong>¥78.00</strong></div>
						</div>
					</div>
				</div>
				<div class="toolbar_footer">
					<div class="pro_total">
						<h3>
							<span>已选</span>
							<strong class="total_count">0</strong>
							<span>件</span>
						</h3>
						<span>
							<strong class="total_price">￥0.00</strong>
						</span>
					</div>
					<div class="pro_cashier">
						<span>结算</span>
					</div>
				</div>
			</div>
		</div>
    </div>
</template>

<script>
  import { mapState } from 'vuex'

  export default {
    computed: {
      ...mapState(['homecasual','categoryList','homeshoplist','userInfo'])
    },
    methods:{
      getRList(cate_id){
        this.$router.replace('/search/' + cate_id + '/1');
      },
      goDetail(id){
        this.$router.replace('/goods/' + id);
      },
    },
    mounted() {
        // 请求轮播图数据
        this.$store.dispatch('reqHomeCasual');
        // 请求分类数据
        this.$store.dispatch('reqCategory');
        // 请求当前用户信息
        this.$store.dispatch('getUserInfo');
    },
    filters: {
        phoneFormat(phone) {
          // 1. 转成数组
          let phoneArr = [...phone];
          console.log(phoneArr);
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
    watch: {
      categoryList() {
        this.$nextTick(() => {
          // 请求首页商品数据
          this.$store.dispatch('reqHomeShopList');
        });
      },
    }
  }
</script>

<style scoped>
  #home{
	font-family:  "Microsoft YaHei";
  }
	/*产品展示、购买、分类简介区*/
	#container{
		position: relative;
		margin: 60px auto;
		width: 100%;
		background: #F5F5F5;
	}
	#container .el-row .el-col{
		height: 100%;
	}
	.el-row .cateList .cate_img{
		width: 100%;
		text-indent: 14px;
		height: 40px;
		color: white;
		line-height: 40px;
		font-size: 16px;
		background: #F10215;
	}
	/*自动播放图片区域*/
	.el-col .el-carousel{
		height: 100%;
		border-top: 2px solid #FF0036;
	}
	.el-carousel .el-carousel__item img{
		height: 100%;
		width: 100%;
	}
	/*一级菜单*/

	/*展示登录信息区域*/
	#container .el-row .con_log.el-col{
		background: white;
		text-align: center;
		font-size: 15px;
		color: #989898;
		border: 1px solid #ccc;
		height: 320px;
	}
	.con_log>div{
		margin-top: -30px;
		margin-left: 75px;
		margin-bottom: 60px;
		width: 70px;
		height: 70px;
	}
	.con_log>div>img{
		width: 100%;
		height: 100%;
		border-radius: 50%;
		box-shadow: 3px 3px 5px 5px #E3E3E3;
	}
	.con_log>p{
		margin-bottom: 20px;
	}
	.con_log>p>a{
    font-size: 13px;
		margin-right:10px;
    margin-bottom: 5px;
		color: #666;
		cursor: pointer;
		text-decoration: none;
	}
  .con_log>.userIn>a{
    display: block;
  }
	.con_log>p>a:hover{
		color: red;
		font-weight: 700;
	}
	.con_log>button{
		margin-right: 5px;
		width: 70px;
		height: 25px;
		line-height: 25px;
		font-size: 12px;
		text-align: center;
		border-radius:13px;
		box-shadow: 6px 8px 20px rgba(45,45,45,0.15);
		transition: background 0.3s ease,color 0.3s ease;
		outline: none;
		border: none;
	}
	.con_log>button.welfare{
		color: #e43f3b;
		background: white;
	}
	.con_log>button.vip{
		color: #e5d790;
		background: #2d2d2a ;
	}
	.con_log>button:hover{
		color: white;
		background: #e43f3b;
	}
	/*每类产品的简单展示*/
	#container>.product{
		margin-top: 50px;
		width: 100%;
		height: 300px;
	}
	.product>.pro_line{
		width: 100%;
		height: 50px;
		text-align: center;
		line-height: 50px;
		font-size: 26px;
		font-family: sans-serif;
		font-weight: normal;
		color: #222;
		margin-bottom: 20px;
	}
	.pro_line>h3{
		display: inline-block;
	}
	.pro_line>div{
		display: inline-block;
		margin-left: 15px;
		cursor: pointer;
	}
	.pro_line>div>a{
		color: red;
		font-weight: 700;
		font-size: 17px;
		text-decoration: none;
		transition: 0.5s;
	}
	.pro_line>div>a:after {
		content: '»';
		opacity: 0;       /*opacity属性不占用文档流的空间*/
		transition: 0.5s;
	}
	.pro_line>div:hover a:after {
		opacity: 1;
	}
	.product>.pro_show{
		margin: 0 auto;
		padding-left: 20px;
		width: 980px;
		height: 200px;
	}
	.pro_show>.pro{
		float: left;
		margin-right: 20px;
		width: 300px;
		height: 100%;
		background: white;
		position: relative;
	}
	.pro>.pro_img{
		margin: 20px;
		width: 120px;
		height: 120px;
	}
	.pro>.pro_text{
		float: right;
		margin-top: 30px;
		height: 130px;
		width: 140px;
		line-height: 25px;
	}
	.pro_text>p{
		margin-bottom: 10px;
	}
	.pro_text>p:first-child{
		color: red;
		font-weight: 900;
	}
	.pro_text>p:nth-child(2){
		font-size: 13px;
	}
	.pro_text>p:nth-child(3){
		font-size: 12px;
		color: #999;
	}
	.pro_1{
		width:100%;
		text-align:center;
		margin-top:300px;
	}
	.pro_1>.item_content{
		width:100%;
		text-align:center;
	}
	.pro>.add_btn{
		float: right;
		position: absolute;
		bottom: 15px;
		right: 20px;
	}
	.add_btn>a{
		display: block;
		width: 120px;
		height: 25px;
		background: #FF0036;
		color: white;
		text-align: center;
		line-height: 25px;
		cursor: pointer;
	}
	/*底部对商城的补充说明*/
	#footer{
		margin-top: -80px;
		width: 100%;
		height: 200px;
		background: #F0F3EF;
	}
	#footer>img{
		display: block;
		margin: 0 auto;
	}
	#footer>.footer_text{
		width: 100%;
		border-top: 1px solid #DEDEDE;
	}
	/*首页的右侧固定栏，查看购物车详情*/
	#meg{
		position: fixed;
		right: 0px;
		top: 0;
		height: 700px;
		width: 35px;
		z-index: 9999;
	}
	#meg>.meg_nav{
		position: absolute;
		top: 0;
		left: 0;
		height: 100%;
		width: 35px;
		background: #000000;
	}
	#meg>.meg_show{
		position: absolute;
		top: 0;
		left: 35px;
		width: 280px;
		height: 100%;
		background: #E6E6E6;
	}
	.meg_nav>.meg_shoppingbag{
		margin-top: 100px;
		width: 100%;
		height: 135px;
	}
	.meg_shoppingbag>img{
		width: 35px;
		height: 35px;
	}
	.meg_shoppingbag>p{
		margin: 5px auto;
		width: 16px;
		height: 48px;
		line-height: 16px;
		text-align: center;
		color: white;
	}
	.meg_shoppingbag>div{
		margin: 10px auto;
		width: 18px;
		height: 18px;
	}
	.meg_shoppingbag>div>span{
		display: inline-block;
		width: 18px;
		height: 18px;
		line-height: 18px;
		border-radius: 50%;
		background: #FF0018;
		color: white;
		text-align: center;
		font-size: 14px;
	}
	.meg_nav>.meg_top{
		display: block;
		position: absolute;
		bottom: 50px;
		width: 100%;
		height: 30px;
	}
	.meg_show>.toolbar_header{
		width: 100%;
		height: 35px;
	}
	.toolbar_header>.pro_Chk{
		float: left;
		width: 25px;
		height: 100%;
	}
	.pro_Chk>#pro_ChkAll{
		display: block;
		width: 12px;
		height: 12px;
		float: right;
		margin-top: 12px;
	}
	.toolbar_header label{
		display: inline-block;
		margin-left: 5px;
		height: 100%;
		line-height: 35px;
		font-size: 12px;
		color: gray;
		cursor: pointer;
	}
	.toolbar_header a{
		display: inline-block;
		float: right;
		height: 100%;
		line-height: 35px;
		font-size: 12px;
		color: gray;
		margin-right: 10px;
	}
	.toolbar_footer{
		position: fixed;
		bottom: 20px;
		padding: 0 16px;
		width: 100%;
		background: #e6e6e6;
		z-index: 99999;
	}
	.toolbar_footer>.pro_total{
		width: 248px;
		height: 30px;
		line-height: 30px;
		background: #e6e6e6;
		color: #333;
	}
	.pro_total>h3{
		float: left;
		width: 100px;
		height: 30px;
		color: #000;
		font-weight: 400;
		font-size: 12px;
	}
	.pro_total>span{
		float: left;
		width: 148px;
		height: 30px;
		text-align: right;
	}
	.pro_total>span>.total_price{
		font-weight: 600;
		color: #ff0036;
		font-size: 12px;
	}
	.pro_cashier{
		width: 248px;
		height: 40px;
		line-height: 40px;
		background: #666;
		color: white;
		text-align: center;
		cursor: not-allowed;
	}
	.btn-allow{
		background: #f22d00;
		cursor: pointer;
	}
	.meg_content{
		width: 100%;
		height: 600px;
		overflow: auto;
	}
	.pro_item{
		width: 100%;
		height: 90px;
		margin-bottom: 15px;
	}
	.pro_item>.item_title{
		padding-left: 12px;
		width: 268px;
		height: 30px;
		line-height: 30px;
		font-size: 12px;
		background: white;
		font-weight: 400;
		cursor: default;
	}
	.item_title>span{
		display: inline-block;
		float: right;
		margin-right: 10px;
		height: 100%;
		line-height: 30px;
		color: #666666;
	}
	.pro_item>.item_content{
		width: 100%;
		height: 60px;
		background: #f6f6f6;
		position: relative;
	}
	.item_content>.pro_Chk{
		float: left;
		width: 25px;
		height: 100%;
	}
	.item_content div{
		display: inline-block;
		margin-right: 5px;
	}
	.pro_Chk>input{
		display: block;
		width: 12px;
		height: 12px;
		float: right;
		margin-top: 24px;
	}
	.item-pic>img{
		margin-top: 8px;
		width: 45px;
		height: 45px;
	}
	.item-info{
		margin-top: 10px;
		width: 50px;
		height: 40px;
		line-height: 20px;
		font-size: 12px;
		color: #999;
		overflow:hidden;
		text-overflow:ellipsis;
		white-space:nowrap
	}
	.item-amout{
		height: 20px;
		line-height: 20px;
		vertical-align: middle;
		margin-top: -35px;
	}
	.item-amout>a{
		display: inline-block;
		height: 18px;
		width: 12px;
		border: 1px solid #e5e5e5;
		background: #f0f0f0;
		text-align: center;
		line-height: 18px;
		color: #444;
		cursor: pointer;
	}
	.item-amout>a:hover{
		color: #f50;
		border-color: #f60;
	}
	.item-amout>.text_amount{
		width: 18px;
		height: 15px;
		text-align: center;
		font-size: 10px;
		display: inline-block;
	}
	.item-sum{
		height: 20px;
		line-height: 20px;
		position: absolute;
		top: 20px;
		right: 5px;
	}
	.item-sum>strong{
		color: #f40;
		font-size: 13px;
	}
</style>
