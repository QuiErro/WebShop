<template>
  <div id="edit-pwd">
    <el-input placeholder="请输入原密码" v-model="oriPwd" show-password clearable></el-input>
    <el-input placeholder="请输入新密码" v-model="newPwd" show-password clearable></el-input>
    <el-input placeholder="请再次输入新密码" v-model="newPwd2" show-password clearable></el-input>
    <p>若没有设置初始密码，则不必输入原密码</p>
    <div class="btn-section">
       <el-button type="primary" @click="goTo('/me/profile')">返回</el-button>
       <el-button type="danger" @click="submitEdit">编辑</el-button>
    </div>
  </div>
</template>

<script>
  import {mapState} from 'vuex'
  import {changeUserPwd} from './../../../api/index'

  export default {
    data(){
      return{
        oriPwd: '',
        newPwd: '',
        newPwd2: ''
      }
    },
    computed: {
      ...mapState(["userInfo"])
    },
    methods: {
      goTo(path){
        this.$router.replace(path);
      },
      async submitEdit(){
        if(!this.newPwd || !this.newPwd2){
          this.$message('输入框内容不得为空！');
          return;
        }
        if(this.newPwd != this.newPwd2){
          this.$message('两次输入的新密码不一致！');
          return;
        }

        let result = await changeUserPwd(this.userInfo.id, this.oriPwd, this.newPwd);
        if(result.success_code === 200){
          this.$message({
            message: result.message,
            type: 'success'
          });
          this.$router.replace('/me/profile');
        }else{
          this.$message.error(result.message);
        }
      }
    }
  }
</script>

<style scoped>
  #edit-pwd{
    padding-top: 10%;
    width: 100%;
    height: 100%;
  }
  .el-input{
    display: block;
    margin: 0 auto 20px;
    width: 30%;
  }
  p{
    margin-top: 40px;
    width: 100%;
    text-align: center;
    font-size: 12px;
    color: #999;
  }
  .btn-section{
    margin: 50px auto;
    width: 25%;

    display: flex;
    justify-content: space-between;
  }
  .btn-section .el-button{
    width: 100px;
    outline: none;
  }
</style>
