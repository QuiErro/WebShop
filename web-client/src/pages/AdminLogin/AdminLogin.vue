<template>
  <div class="login-container">
    <!--登录面板内容部分-->
    <div class="login-inner">
      <!--面板头部-->
      <div class="login-header">
        <div class="login-logo">
          <img src="./images/logo-round.png" alt="" width="150">
        </div>
      </div>
      <!--面板表单部分-->
      <div class="login-content">
        <!--账号登录部分-->
        <form>
          <div class="current">
            <section class="login-message">
              <input type="text" maxlength="11" placeholder="用户名" v-model="user_name">
            </section>
            <section class="login-verification">
              <input type="password" maxlength="18" placeholder="密码" v-if="pwdMode" v-model="pwd">
              <input type="text" maxlength="18" placeholder="密码" v-else v-model="pwd">
              <div class="switch-show">
                <img @click.prevent="dealPwdMode(false)" :class="{on: pwdMode}" src="./images/hide_pwd.png" alt=""
                       width="20">
                <img @click.prevent="dealPwdMode(true)" :class="{on: !pwdMode}" src="./images/show_pwd.png" alt=""
                       width="20">
              </div>
            </section>
          </div>
          <button class="login-submit" @click.prevent="login()">登录</button>
        </form>
        <button class="login-back" @click="$router.back()">返回</button>
      </div>
    </div>
  </div>
</template>

<script>
  import { MessageBox } from 'element-ui'
  import { adminLogin } from '../../api/index'

  export default {
    name: "Login",
    data() {
      return {
        pwdMode: true, // 密码的显示方式 true 密文 false 明文
        pwd: '', // 密码
        user_name: '', // 用户名
        adminInfo: {},
      }
    },
    methods: {
      // 密码的显示方式
      dealPwdMode(flag) {
        this.pwdMode = flag;
      },
      // 登录
      async login() {
        // 前端校验
        if (!this.user_name) {
		      MessageBox({
            type: 'info',
            message: "请输入用户名",
			      showClose: true,
          });
          return;
        } else if (!this.pwd) {
	        MessageBox({
            type: 'info',
            message: "请输入密码!",
		        showClose: true,
          });
          return;
        }
        let result = await adminLogin(this.user_name, this.pwd);
        if(result.success_code === 200){
          MessageBox({
              type: 'success',
              message: result.message,
			        showClose: true,
          });
          this.adminInfo.user_name = this.user_name;
          this.$router.replace('/admin');
          window.localStorage.setItem("adminInfo",JSON.stringify(this.adminInfo));
          window.localStorage.removeItem("userInfo");
        }else{
          MessageBox({
              type: 'error',
              message: result.message,
			        showClose: true,
          });
        }
      }
    }
  }
</script>

<style scoped lang="stylus" rel="stylesheet/stylus">
  @import "../../common/stylus/mixins.styl"
  .login-container
    width 100%
    height 100%
    background #fff
    .login-inner
      padding-top 60px
      width 25%
      margin 0 auto
      .login-header
        .login-logo
          font-size 20px
          font-weight bold
          color mediumpurple
          text-align center
          > a
            color #333
            font-size 14px
            padding-bottom 4px
            &:first-child
              margin-right 40px
            &.current
              color mediumpurple
              font-weight 700
              border-bottom 2px solid mediumpurple
      .login-content
        > form
          > div
            display none
            &.current
              display block
            input
              width 100%
              height 100%
              padding-left 8px
              box-sizing border-box
              border 1px solid #ddd
              border-radius 4px
              outline 0
              font 400 14px Arial
              &:focus
                border 1px solid mediumpurple
            .login-message
              position relative
              margin-top 16px
              height 48px
              font-size 14px
              background #fff
            .login-verification
              position relative
              margin-top 16px
              height 48px
              font-size 14px
              background #fff
              .switch-show
                position absolute
                right 10px
                top 12px
                img
                  display none
                img.on
                  display block
          .login-submit
            display block
            width 100%
            height 42px
            margin-top 30px
            border-radius 4px
            background mediumpurple
            color #fff
            text-align center
            font-size 16px
            line-height 42px
            border 0
        .login-back
          display block
          width 100%
          height 42px
          margin-top 15px
          border-radius 4px
          background transparent
          border: 1px solid mediumpurple
          color mediumpurple
          text-align center
          font-size 16px
          line-height 42px
</style>
