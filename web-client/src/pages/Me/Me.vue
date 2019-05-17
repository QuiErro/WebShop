<template>
  <div id="me">
    <nav class="navbar navbar-dark fixed-top bg-dark flex-md-nowrap p-0 shadow">
      <router-link class="navbar-brand col-sm-3 col-md-2 mr-0" to="/home">西二商城</router-link>
      <ul class="navbar-nav px-3">
        <li class="nav-item text-nowrap">
          <a class="nav-link" @click.prevent="goBack">返回商城</a>
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
              <el-menu-item index="1"  @click="goTo('/me/profile')">
                <i class="el-icon-document-copy"></i>
                <span slot="title">我的资料</span>
              </el-menu-item>
              <el-menu-item index="2" @click="goTo('/me/update')">
                <i class="el-icon-edit"></i>
                <span slot="title">编辑信息</span>
              </el-menu-item>
              <el-submenu index="3">
                <template slot="title">
                  <i class="el-icon-collection-tag"></i>
                  <span>我的订单</span>
                </template>
                <el-menu-item-group>
                  <el-menu-item index="3-1" @click="goTo('/me/sales')">待付款</el-menu-item>
                  <el-menu-item index="3-2" @click="goTo('/me/sales')">待发货</el-menu-item>
                  <el-menu-item index="3-3" @click="goTo('/me/sales')">待收货</el-menu-item>
                </el-menu-item-group>
              </el-submenu>
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

  export default {
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
          this.$router.replace('/home');
          window.localStorage.removeItem("userInfo");
        }).catch(() => {
          this.$message({
            type: 'info',
            message: '已取消退出'
          });
        });
      },
      goBack(){
        this.$router.replace('/home');
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
