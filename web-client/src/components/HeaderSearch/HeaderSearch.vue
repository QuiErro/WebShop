<template>
  <div class="header_container">
    <div class="header_img"><img src="../../common/img/logo-round.png" /></div>
		<div class="header_search">
				<form>
					<input type="text" placeholder="搜索  商品名称" v-model="keywords"/>
          <el-button type="danger" icon="el-icon-search" @click="postSearch"></el-button>
				</form>
				<p>
					<a>自营日满减</a>
					<a>西二女装</a>
					<a>笔记本电脑</a>
					<a>电子书</a>
					<a>限时秒杀</a>
				</p>
		</div>
		<div class="shopping_bag">
			<a @click.prevent="goShopCar"><i class="el-icon-shopping-cart-2"></i>&nbsp;&nbsp;我的购物车</a>
		</div>
	</div>
</template>

<script>
  import { MessageBox } from 'element-ui'
  import {mapState} from 'vuex'
  import {mapActions} from 'vuex'

  export default {
    data(){
      return{
        keywords: ''
      }
    },
    computed: {
      ...mapState(['userInfo'])
    },
    methods:{
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
      async postSearch(){
        if(this.keywords){
          let keywords = this.keywords;
          this.$store.dispatch('reqSearch',{keywords});
          this.$router.replace('/searchdetail');
        }
      },
    },
  }
</script>

<style scoped>
/*头部搜索区*/
.header_container{
	position: relative;
	width: 100%;
  height: 140px;
  margin: 0;
  padding: 0;
}
/*商城标识图片区域*/
.header_container>.header_img{
	position: absolute;
	left: 100px;
	margin-top: 10px;
	width: 140px;
	height: 140px;
  border: 1px solid darkgray;
  box-shadow: 2px 4px 15px rgba(45,45,45,0.15);
  border-radius: 50%;
}
.header_img>img{
	width: 100%;
	height: 100%;
	border-radius: 50%;
}
/*鼠标移入图片实现3d动画*/
.header_img:hover{
	transform-style: preserve-3d;
	transform:rotateY(360deg);
    transition: all 1500ms;
    -moz-transform-style: preserve-3d;
	-moz-transform:rotateY(45deg);
	-moz-transition: all 1500ms;
}
.header_search{
	position: absolute;
	left: 50%;
	margin-left: -290px;
	margin-top: 50px;
}
.header_search form{
  display: flex;
  align-items: center;
}
.header_search input{
	padding-left: 10px;
	width: 490px;
	height: 35px;
	font-size: 14px;
	line-height: 35px;
	border: 2px solid #FF0236;
  border-right: none;
	outline: none;
}
.header_search button.el-button.el-button--danger{
  padding: 0;
  width: 60px;
  height: 35px;
	font-size: 18px;
  border-radius: 0;
  outline: none;

  display: flex;
  justify-content: center;
  align-items: center;
}
.header_search>p>a{
	display: inline-block;
	padding: 5px 10px;
	font-size: 12px;
	color: #999;
	cursor: pointer;
}
.header_search>p>a:hover{
	color: red;
}
/*头部的购物车标记区域*/
.header_container>.shopping_bag{
	position: absolute;
	margin-top: 60px;
	right: 120px;
	width: 190px;
	height: 35px;
	text-align: center;
	line-height: 35px;
	font-size: 12px;
	background: #f8f9fa;
	color: red;
	cursor: pointer;
}
.shopping_bag>img{
	display: inline-block;
	margin-left: 5px;
	margin-top: 5px;
	width: 17px;
	height: 17px;
}
.shopping_bag>a{
	color: red;
}
</style>
