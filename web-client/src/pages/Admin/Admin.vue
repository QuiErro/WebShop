<template>
  <div id="admin">
    <nav class="navbar navbar-dark fixed-top bg-dark flex-md-nowrap p-0 shadow">
      <router-link class="navbar-brand col-sm-3 col-md-2 mr-0" to="/home">西二商城</router-link>
      <span class="nav_title">欢迎来到后台管理界面</span>
      <ul class="navbar-nav px-3">
        <li class="nav-item text-nowrap">
          <router-link class="nav-link" to="/home">返回商城</router-link>
        </li>
        <li class="nav-item text-nowrap">
          <a class="nav-link" @click="logout">退出登录</a>
        </li>
      </ul>
    </nav>

    <div class="container-fluid">
      <div class="row">
        <nav class="col-md-2 d-none d-md-block bg-light sidebar">
          <div class="sidebar-sticky">
            <a class="navbar-brand">
              <img src="./images/no_login.jpg" class="navbar-brand-img
              mx-auto" alt="...">
            </a>
            <el-menu
              default-active="1"
              class="el-menu-vertical-demo">
              <el-menu-item index="1"  @click="goTo('/admin/admingoods')">
                <i class="el-icon-document-copy"></i>
                <span slot="title">商品信息</span>
              </el-menu-item>
              <el-menu-item index="2" @click="goTo('/admin/addgoods')">
                <i class="el-icon-edit"></i>
                <span slot="title">商品上架</span>
              </el-menu-item>
              <el-menu-item index="3" @click="goTo('/admin/adminusers')">
                <i class="el-icon-collection-tag"></i>
                <span>用户管理</span>
              </el-menu-item>
              <el-menu-item index="4" @click="goTo('/admin/adminsales')">
                <i class="el-icon-collection-tag"></i>
                <span>订单管理</span>
              </el-menu-item>
            </el-menu>
          </div>
        </nav>
       <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
         <router-view></router-view>
       </main>
      </div>
    </div>
  </div>
</template>

<script>
  import {mapState} from 'vuex';
  import {mapActions} from 'vuex'
  import { MessageBox } from 'element-ui';
  import {adminLogout} from '../../api/index'

  export default {
    created(){
       let result = window.localStorage.getItem("adminInfo");
        if(!result){
          MessageBox({
            type: 'info',
            message: "您还没登录",
			      showClose: true,
          });
          this.$router.replace('/adminlogin');
        }else{
          window.localStorage.removeItem("userInfo");
        }
    },
    methods:{
      logout(){
        this.$confirm('您确定退出登录吗?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(async () => {
          let result = await adminLogout();
          if(result.success_code === 200){
             this.$message({
              type: 'success',
              message: '退出成功!'
            });
            this.$router.replace('/home');
            window.localStorage.removeItem("adminInfo");
          }
        }).catch(() => {
          this.$message({
            type: 'info',
            message: '已取消退出'
          });
        });
      },
      goTo(path){
        this.$router.replace(path);
      },
    },
  }
</script>

<style scoped>

.bd-placeholder-img {
  font-size: 1.125rem;
  text-anchor: middle;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
}

@media (min-width: 768px) {
  .bd-placeholder-img-lg {
    font-size: 3.5rem;
  }
}
#me {
  font-size: .875rem;
}

.feather {
  width: 16px;
  height: 16px;
  vertical-align: text-bottom;
}

/*
 * Sidebar
 */

.sidebar {
  position: fixed;
  top: 0;
  bottom: 0;
  left: 0;
  z-index: 100; /* Behind the navbar */
  padding: 48px 0 0; /* Height of navbar */
  box-shadow: inset -1px 0 0 rgba(0, 0, 0, .1);
}

.sidebar-sticky {
  position: relative;
  top: 0;
  height: calc(100vh - 48px);
  padding-top: .5rem;
  overflow-x: hidden;
  overflow-y: auto; /* Scrollable contents if viewport is shorter than content. */
}

@supports ((position: -webkit-sticky) or (position: sticky)) {
  .sidebar-sticky {
    position: -webkit-sticky;
    position: sticky;
  }
}

.sidebar .nav-link {
  font-weight: 500;
  color: #333;
}
.sidebar-sticky .navbar-brand {
    display: block;
    text-align: center;
    padding-top: 1.25rem;
    padding-bottom: 1.25rem;
    color: #12263f;
    margin-right: 0;
    font-size: 1.0625rem;
    line-height: inherit;
    white-space: nowrap;
    background: #f8f9fa;
}
.navbar-brand img{
  border-radius: 50%;
}
.sidebar .nav-link .feather {
  margin-right: 4px;
  color: #999;
}

.sidebar .nav-link.active {
  color: #007bff;
}

.sidebar .nav-link:hover .feather,
.sidebar .nav-link.active .feather {
  color: inherit;
}

.sidebar-heading {
  font-size: .75rem;
  text-transform: uppercase;
}

/*
 * Content
 */

[role="main"] {
  padding-top: 133px; /* Space for fixed navbar */
}

@media (min-width: 768px) {
  [role="main"] {
    padding-top: 48px; /* Space for fixed navbar */
  }
}

/*
 * Navbar
 */
.nav_title{
  color: white;
}
.navbar-brand {
  padding-top: .75rem;
  padding-bottom: .75rem;
  font-size: 1rem;
  background-color: rgba(0, 0, 0, .25);
  box-shadow: inset -1px 0 0 rgba(0, 0, 0, .25);
}

.navbar-nav{
  flex-direction: row !important;
}
.navbar-nav>.nav-item{
  margin-left: 40px;
  cursor: pointer;
}
</style>
