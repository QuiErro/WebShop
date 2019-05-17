<template>
  <div id="addgoods">
    <h3>商品上架</h3>
    <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
      <el-form-item label="商品ID" prop="goods_id" style="width:250px">
        <el-input v-model="ruleForm.goods_id" type="number"></el-input>
      </el-form-item>
      <el-form-item label="商品名称" prop="short_name" style="width:500px">
        <el-input v-model="ruleForm.short_name"></el-input>
      </el-form-item>
      <el-form-item label="商品特价" prop="price" style="width:250px">
        <el-input v-model="ruleForm.price" type="number"></el-input>
      </el-form-item>
      <el-form-item label="商品库存" prop="counts" style="width:250px">
        <el-input v-model="ruleForm.counts" type="number"></el-input>
      </el-form-item>
      <el-form-item label="商品分类" prop="category">
        <el-select v-model="ruleForm.category" placeholder="请选择">
          <el-option
           v-for="item in options"
          :key="item.value"
          :label="item.label"
          :value="item.value">
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="商品标签" prop="sales_tip" style="width:500px">
        <el-input v-model="ruleForm.sales_tip"></el-input>
      </el-form-item>
      <el-form-item label="商品详情" prop="goods_name" style="width:500px">
        <el-input type="textarea" v-model="ruleForm.goods_name" autosize></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="submitForm('ruleForm')">立即创建</el-button>
        <el-button @click="resetForm('ruleForm')">重置</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
  import {mapState} from 'vuex';
  import {addGoodsToRecom, getAllgoods} from './../../../api/index';

  export default {
    data() {
      return {
        ruleForm: {
          goods_id: null,
          short_name: '',
          goods_name: '',
          price: null,
          sales_tip: '',
          counts: null,
          category: 1
        },
        rules: {
          goods_id: [
            { required: true, message: '请输入商品ID', trigger: 'blur' }
          ],
          short_name: [
            { required: true, message: '请输入商品名称', trigger: 'blur' }
          ],
          goods_name: [
            { required: true, message: '请填写商品详情', trigger: 'blur' }
          ],
          price: [
            { required: true, message: '请输入商品特价', trigger: 'blur' }
          ],
          counts: [
            { required: true, message: '请输入商品库存', trigger: 'blur' }
          ],
          category: [
            { required: true, message: '请选择商品分类号', trigger: 'blur' }
          ],
          sales_tip: [
            { required: true, message: '请输入商品标签', trigger: 'blur' }
          ],
        },
        options: [{
          value: 1,
          label: '图书、音像'
        }, {
          value: 2,
          label: '家居生活'
        },{
          value: 3,
          label: '服饰、箱包'
        },{
          value: 4,
          label: '电子产品'
        },{
          value: 5,
          label: '美食宝典'
        }],
      };
    },
    methods: {
      async submitForm(formName) {
        let flag = false;
        this.$refs[formName].validate((valid) => {
          if (valid) {
            this.$refs[formName].model.goods_id = Number(this.$refs[formName].model.goods_id);
            this.$refs[formName].model.counts = Number(this.$refs[formName].model.counts);
            this.$refs[formName].model.price = Number(this.$refs[formName].model.price);
            // console.log(this.$refs[formName].model);
            flag = true;
          }
        });
        if(flag){
          let result = await addGoodsToRecom({
            goods_id: this.$refs[formName].model.goods_id,
            short_name: this.$refs[formName].model.short_name,
            goods_name: this.$refs[formName].model.goods_name,
            counts: this.$refs[formName].model.counts,
            price: this.$refs[formName].model.price,
            sales_tip: this.$refs[formName].model.sales_tip,
            category: this.$refs[formName].model.category
          });
          if(result.success_code === 200){
            this.$message({
              type: 'success',
              message: '添加成功'
            });
            this.$router.replace('/admin');
            getAllgoods();
          }else if(result.success_code === 500){
            this.$message({
              type: 'info',
              message: '商品已存在'
            });
          }else{
            this.$message({
              type: 'error',
              message: '添加失败'
            });
          }
        }
      },
      resetForm(formName) {
        this.$refs[formName].resetFields();
      }
    }
  }
</script>

<style scoped>
#addgoods{
  padding-top: 20px;
}
#addgoods>h3{
  font-weight: bolder;
  margin: 10px 10px 30px 10px;
}
</style>

