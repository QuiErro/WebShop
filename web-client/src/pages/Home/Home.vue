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
					  <el-menu-item index="cate.cate_id" v-for="(cate) in categoryList" :key="cate.cate_id" @click="getRList(cate.cate_id)">
              <i :class="cate.cate_icon"></i>
              <span slot="title">{{cate.cate_name}}</span>
					  </el-menu-item>
					</el-menu>
			  </el-col>
			  <!--轮播图-->
				<el-col :span="14">
					<el-carousel v-if="homecasual.length > 0">
					  <el-carousel-item v-for="(casual) in homecasual" :key="casual.id">
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
			<div class="product" v-for="(cate) in categoryList" :key="cate.cate_id">
				<div class="pro_line">
					<h3>{{ cate.cate_name }}</h3><div><a @click.prevent="getRList(cate.cate_id)">MORE</a></div>
				</div>
				<div class="pro_show">
          <ProductItem v-for="(pro) in homeshoplist[cate.cate_id - 1]" :key="pro.goods_id" :pro="pro"/>
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
    <DrawerSection v-if="this.$route.path.indexOf('/home') != -1" @goShopCar="goShopCar"/>
  </div>
</template>

<script>
  import { mapState } from 'vuex'
  import DrawerSection from './children/DrawerSection/DrawerSection'
  import ProductItem from '../../components/ProductItem/ProductItem'
  import { MessageBox } from 'element-ui'

  export default {
    computed: {
      ...mapState(['homecasual','categoryList','homeshoplist','userInfo'])
    },
    components: {
      DrawerSection,
      ProductItem
    },
    methods:{
      getRList(cate_id){
        this.$router.replace('/search/' + cate_id + '/1');
      },
      goShopCar(){
        if(this.userInfo.id){
          this.$router.replace('/shopcar');
        }else{
          MessageBox({
            type: 'info',
            message: "请先登录!",
			      showClose: true,
          });
        }
      },
    },
    mounted() {
        // 请求轮播图数据
        this.$store.dispatch('reqHomeCasual');
        // 请求分类数据
        this.$store.dispatch('reqCategory');
        // 请求当前用户信息
        this.$store.dispatch('getUserInfo');
        // 请求商品数据
        if(this.userInfo && this.userInfo.id){
          let user_id = this.userInfo.id;
          this.$store.dispatch('reqCartsGoods',{user_id});
        }
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
		background: rgba(245, 245, 245, 0.5);
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
	.pro_1{
		width:100%;
		text-align:center;
		margin-top:300px;
	}
	.pro_1>.item_content{
		width:100%;
		text-align:center;
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
</style>
