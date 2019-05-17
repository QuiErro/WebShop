<template>
  <div class="user-detail">
    <div class="user-detail-top">基本信息</div>
    <div class="user-detail-group">
      <div class="user-icon">
        <span>头像</span>
        <img src="../images/no_login.jpg" alt="">
      </div>
      <div class="user-item">
        <span>手机</span>
        <span>{{ userInfo.user_phone }}</span>
      </div>
      <div class="user-item">
        <span>昵称</span>
        <el-input
          type="text"
          placeholder="请输入内容"
          v-model="user_name"
          maxlength="15"
          show-word-limit
          clearable
          style="width:200px"
        >
        </el-input>
      </div>
      <div class="user-item">
        <span>性别</span>
        <el-select v-model="user_sex" placeholder="请选择">
          <el-option
           v-for="item in options"
          :key="item.value"
          :label="item.label"
          :value="item.value">
          </el-option>
        </el-select>
      </div>
      <div class="user-item">
        <span>常住地</span>
        <el-input
          type="text"
          placeholder="请输入内容"
          v-model="user_address"
          maxlength="25"
          show-word-limit
          clearable
          style="width:300px"
        >
        </el-input>
      </div>
      <div class="user-item">
        <span>生日</span>
        <el-date-picker
          v-model="user_birthday"
          type="date"
          placeholder="选择日期"
          value-format="yyyy-MM-dd">
        </el-date-picker>
      </div>
      <div class="user-item">
        <span>个性签名</span>
        <el-input
          type="text"
          placeholder="请输入内容"
          v-model="user_sign"
          maxlength="15"
          show-word-limit
          clearable
          style="width:220px"
        >
        </el-input>
      </div>

      <button @click="saveUserInfo()">编辑个人信息</button>
    </div>
  </div>
</template>

<script>
  import {mapState} from 'vuex';
  import {changeUserInfo} from './../../../api/index';

  export default {
    data() {
      return {
        user_sign: '',
        user_address: '',
        user_name: '',
        user_sex: '',
        user_phone: '',
        user_birthday: '',

        options: [{
          value: '男',
          label: '男'
        }, {
          value: '女',
          label: '女'
        }],
      }
    },
     mounted(){
        this.user_sign = this.userInfo.user_sign || '';
        this.user_address = this.userInfo.user_address || '';
        this.user_name = this.userInfo.user_name || '';
        this.user_sex = this.userInfo.user_sex || '';
        this.user_phone= this.userInfo.user_phone || '';
        this.user_birthday= this.userInfo.user_birthday || '';
    },
    computed: {
      ...mapState(["userInfo"])
    },
    methods:{
      // 修改用户信息
      async saveUserInfo(){
          // 3.1 请求接口
          let result = await changeUserInfo(this.userInfo.id, this.user_name, this.user_sex, this.user_address, this.user_birthday, this.user_sign);
        // 3.3 返回主界面
        if(result.success_code === 200){
            // 3.2 提示用户
            this.$message({
                type: 'success',
                message: result.message
            });
            // 3.4 更新本地数据
            this.$store.dispatch('getUserInfo',{user_id: this.userInfo.id});
            // 3.5 返回主界面
            setTimeout(()=>{
               this.$router.replace('/me/profile');
            }, 2000)
        }
      }
    },
  }
</script>

<style scoped lang="stylus" ref="stylesheet/stylus">
  .user-detail
    width 70%
    height 100%
    margin 20px auto
    .user-detail-top
      width 100%
      height 60px
      line-height 60px
      padding-left 10px
      font-weight bold
    .user-detail-group
      .user-icon
        height 60px
        padding 0 10px
        background-color #fff
        border-bottom: 1px solid #e0e0e0
        display flex
        justify-content space-between
        align-items center
        img
          width 50px
          border-radius 50%
      .user-item
        height 50px
        padding 0 10px
        background-color #fff
        border-bottom: 1px solid #e0e0e0
        display flex
        justify-content space-between
        align-items center
        input
          border 1px solid #ccc
          outline none
          text-align right
          width 200px
      button
        width 20%
        height 40px
        line-height 40px
        background-color #e9232c
        text-align center
        margin 60px 0
        border none
        font-size 16px
        color #fff
        border-radius 10px
    .right-title-color
      color #999
      font-size 14px
</style>

