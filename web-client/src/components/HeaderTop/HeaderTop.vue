<template>
		<div class="header_nav">
			<div>
        <p>嗨~欢迎来到西二商城</p>
        <div class="locationWrapper">
           <svg viewBox="0 0 32 32" class="icon iconLocation">
                <path fill="#81838E" fill-rule="evenodd"
                      d="M14.521 30.445c.817.738 2.142.75 2.958 0 0 0 11.521-9.82 11.521-17.158C29 5.95 23.18 0 16 0S3 5.949 3 13.287c0 7.339 11.521 17.158 11.521 17.158zM16 18a5 5 0 1 0 0-10 5 5 0 0 0 0 10z"></path>
            </svg>
            <span class="address">{{selectedOptions[2] || city || '福州市'}}</span>
            <svg viewBox="0 0 32 32" class="icon iconArrow">
                <path fill="#81838E" fill-rule="evenodd"
                      d="M14.724 19.17c.783.784 2.05.788 2.837 0l5.047-5.047c1.173-1.172.776-2.123-.869-2.123H10.545c-1.652 0-2.04.952-.869 2.123l5.048 5.048z"></path>
            </svg>
          <el-cascader
            :options="options"
            :props="{ expandTrigger: 'hover' }"
            :show-all-levels="false"
            v-model="selectedOptions"
            @change="handleAreaChange"
            :separator="' '"
          />
        </div>
      </div>
			<ul>
				<li v-if="!userInfo.id">
					<router-link to="/login">您好,请登录</router-link><router-link to="/login">免费注册</router-link>
				</li>
				<li v-else>
					<a v-if="userInfo.user_nickname">您好,{{ userInfo.user_nickname }}</a>
          <a v-else>您好,{{ userInfo.user_name | nameFormat }}</a>
					<a @click="headerLogout">退出登录</a>
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
  // 引入三级联动的城市数据
  import options from '@/config/area.js'

  export default {
    data(){
      return{
        selectedOptions: [], //存放选择的城市
        options:options,     //存放城市数据
        city: '',  // 定位的城市
      }
    },
    mounted() {
      this.getLocation();
    },
    computed: {
        ...mapState(["userInfo"])
    },
    methods:{
      ...mapActions(["logOut"]),

      handleAreaChange(value) {
        //console.log(this.selectedOptions);
      },
      getLocation(){
        let geolocation = new qq.maps.Geolocation("3PXBZ-DOQK6-FQISF-M2BXT-MOETT-L6FIM", "myapp");
        geolocation.getLocation(this.showPosition, this.showError);
      },
      showPosition(position){
        this.city = position.city;
      },
      showError(){
        console.log('定位失败');
        // 继续定位
        this.getLocation();
      },
      headerLogout(){
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

  display: flex;
  align-items: center;
  justify-content: space-between;
}
.header_nav>div{
  display: flex;
  align-items: center;
}
.header_nav>div p{
	margin: 0 30px 0 20px;
	color: #999;
	font-size: 15px;
}
.locationWrapper{
  position: relative;
  max-width: 100px;

  display: flex;
  align-items: center;

}
.locationWrapper .el-cascader{
  position: absolute;
  opacity: 0;
}
.locationWrapper .address{
  max-width: 58px;
  font-size: 12px;
  color: #999;
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
  vertical-align: middle;
}
.locationWrapper .icon{
  margin: 0 3px;
  width: 15px;
  height: 15px;
  vertical-align: middle;
}
.locationWrapper .icon path{
  fill: #dd6161;
}
.header_nav>ul{
	margin: 0 50px;
	list-style: none;

  display: flex;
  align-items: center;
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
