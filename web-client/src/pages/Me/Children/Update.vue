<template>
  <div class="user-detail">
    <div class="user-detail-top">基本信息</div>
    <div class="user-detail-group">
      <div class="user-icon">
        <span>头像</span>
        <el-upload
          class="avatar-uploader"
          action=""
          :auto-upload="false"
          :show-file-list="false"
          :before-upload="beforeAvatarUpload"
          :on-change="handleAvatarChange"
        >
          <img v-if="user_avatar" :src="user_avatar_imgUrl" class="avatar">
          <img v-else src="../images/no_login.jpg" class="avatar">
          <i class="el-icon-plus avatar-uploader-icon"></i>
        </el-upload>
      </div>
      <div class="user-item">
        <span>手机</span>
        <span>{{ userInfo.user_phone || "暂未设置" }}</span>
      </div>
      <div class="user-item">
        <span>账号</span>
        <span>{{ userInfo.user_name || "暂未设置" }}</span>
      </div>
      <div class="user-item">
        <span>昵称</span>
        <el-input
          type="text"
          placeholder="请输入内容"
          v-model="user_nickname"
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

      <el-button type="danger" @click="saveUserInfo()">编辑</el-button>
    </div>
  </div>
</template>

<script>
  import {mapState} from 'vuex'
  import {changeUserInfo} from './../../../api/index'
  import {fileToBase64Url} from "@/config/utils"

  export default {
    data() {
      return {
        user_sign: '',
        user_address: '',
        user_nickname: '',
        user_sex: '',
        user_phone: '',
        user_birthday: '',
        user_avatar_imgUrl: '',
        user_avatar: null,

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
        this.user_nickname = this.userInfo.user_nickname || '';
        this.user_sex = this.userInfo.user_sex || '';
        this.user_phone= this.userInfo.user_phone || '';
        this.user_birthday= this.userInfo.user_birthday || '';
    },
    computed: {
      ...mapState(["userInfo"])
    },
    methods:{
      beforeAvatarUpload(file) {
        const isJPG = file.type === 'image/jpeg' || file.type === 'image/png';
        const isLt2M = file.size / 1024 / 1024 < 1;

        if (!isJPG) {
          this.$message.error('上传头像图片只能是 JPG 或 PNG 格式!');
        }
        if (!isLt2M) {
          this.$message.error('上传头像图片大小不能超过 1MB!');
        }
        return isJPG && isLt2M;
      },
      handleAvatarChange(file, fileList){
        this.user_avatar_imgUrl = URL.createObjectURL(file.raw);
        this.user_avatar = file.raw;
      },
      // 修改用户信息
      async saveUserInfo(){
          // 3.1 请求接口
          let formData = new FormData();
          formData.append('id', this.userInfo.id);
          formData.append('user_nickname', this.user_nickname);
          formData.append('user_sex', this.user_sex);
          formData.append('user_address', this.user_address);
          formData.append('user_birthday', this.user_birthday);
          formData.append('user_sign', this.user_sign);
          if(this.user_avatar){
            formData.append('user_avatar', this.user_avatar);
          }

          let result = await changeUserInfo(formData);
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

<style scoped>
  .user-detail{
    width: 70%;
    height: 100%;
    margin: 20px auto;
  }
  .user-detail-top{
    width: 100%;
    height: 60px;
    line-height: 60px;
    padding-left: 10px;
    font-weight: bold;
  }
  .user-detail-group .user-icon{
    height: 60px;
    padding: 0 10px;
    background-color: #fff;
    border-bottom: 1px solid #e0e0e0;

    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  .user-detail-group .user-item{
    height: 50px;
    padding: 0 10px;
    background-color: #fff;
    border-bottom: 1px solid #e0e0e0;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  .user-detail-group input{
    border: 1px solid #ccc;
    outline: none;
    text-align: right;
    width: 200px;
  }
  .user-detail-group button{
    margin: 60px 0;
    width: 15%;
    font-size: 16px;
    border-radius: 10px;
    border: none;
    outline: none;
  }
  .right-title-color{
    color: #999;
    font-size: 14px;
  }
  .avatar-uploader{
    position: relative;
    width: 56px;
    height: 56px;
  }
  .avatar-uploader /deep/ .el-upload.el-upload--text {
    width: 100%;
    height: 100%;
    border-radius: 50%;
    cursor: pointer;
    overflow: hidden;
  }
  .avatar-uploader-icon {
    position: absolute;
    left: 0;
    top: 0;
    font-size: 28px;
    color: #8c939d;
    width: 100%;;
    height: 100%;
    line-height: 56px;
    text-align: center;
    opacity: 0;
  }
  .avatar-uploader-icon:hover{
    opacity: 1;
  }
  .avatar {
    position: absolute;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    border-radius: 50%;
  }
</style>

