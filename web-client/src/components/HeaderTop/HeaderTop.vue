<template>
		<div class="header_nav">
			<p>嗨~欢迎来到西二商城</p>
			<ul>
				<li v-if="!userInfo.id">
					<router-link to="/login">您好,请登录</router-link><router-link to="/login">免费注册</router-link>
				</li>
				<li v-else>
					<a>您好,{{ userInfo.user_phone | phoneFormat }}</a>
					<a @click="logout">退出登录</a>
				</li>
        <li v-if="this.$route.path.indexOf('/home') === -1"><router-link to="/home">返回首页</router-link></li>
				<li><a @click.prevent="goMe">个人中心</a></li>
        <li><a @click.prevent="goShopCar">我的购物车</a></li>
				<li><a @click.prevent="goAdmin">管理员通道</a></li>
				<li><a>联系客服</a></li>
				<li><a>网站导航</a></li>
			</ul>
		</div>
</template>

<script>
  import {mapState} from 'vuex';
  import {mapActions} from 'vuex'
  import { MessageBox } from 'element-ui';

  export default {
    computed: {
        ...mapState(["userInfo"])
    },
    methods:{
      ...mapActions(["logOut"]),
      logout(){
        this.$confirm('您确定退出登录吗?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.$message({
          type: 'success',
          message: '退出成功!'
          });
          let result = this.logOut({});
          window.localStorage.removeItem("userInfo");
        }).catch(() => {
          this.$message({
            type: 'info',
            message: '已取消退出'
          });
        });
      },
      goMe(){
        if(this.userInfo.id){
          this.$router.replace('/me');
        }else{
          MessageBox({
            type: 'info',
            message: "请先登录!",
			      showClose: true,
          });
        }
      },
      goAdmin(){
        let result = window.localStorage.getItem("adminInfo");
        if(result){
          this.$router.replace('/admin');
        }else{
          this.$router.replace('/adminlogin');
        }
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
  }
</script>

<style scoped>
/*头部导航*/
.header_nav{
	width: 100%;
	height: 30px;
	background: #F2F2F2;
	font-family:  "Microsoft YaHei";
}
.header_nav>p{
	float: left;
	margin-left: 50px;
	height: 30px;
	line-height: 30px;
	color: #999;
	font-size: 15px;
}
.header_nav>ul{
	float: right;
	margin-right: 50px;
	list-style: none;
}
.header_nav>ul>li{
	float: left;
}
.header_nav>ul>li:first-child{
	font-size: 14px;
	color:red;
	line-height: 20px;
	cursor: pointer;
}
.header_nav>ul>li>a{
	display: inline-block;
	padding: 5px 15px;
	font-size: 12px;
	line-height: 20px;
	color: #999;
	text-decoration: none;
	cursor: pointer;
}
.header_nav>ul>li>a:hover{
	color: red;
}
.header_nav>ul>li:first-child>a:nth-child(2){
	padding-left: 0;
	color: red;
}
</style>
