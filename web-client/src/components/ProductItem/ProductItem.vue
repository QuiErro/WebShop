<template>
  <div class="pro">
		<img v-lazy="pro.thumb_url" class="pro_img">
		<div class="pro_text">
			<p><em>{{ pro.price / 100 | moneyFormat }}</em></p>
			<p>{{ pro.short_name }}</p>
			<p>西二商城自营店</p>
		</div>
		<div class="add_btn">
			<a @click="goDetail(pro.goods_id)"><el-button type="danger">查看详情</el-button></a>
		</div>
	</div>
</template>

<script>
  import {mapState} from 'vuex'

  export default {
    props: {
      pro: {
        type: Object,
        required: true
      }
    },
    methods: {
      goDetail(id){
        this.$router.replace('/goods/' + id);
      },
    }
  }
</script>

<style scoped>
.pro{
		float: left;
		margin-right: 20px;
		width: 300px;
		height: 100%;
		background: white;
		position: relative;
	}
	.pro>.pro_img{
		margin: 20px;
		width: 120px;
		height: 120px;
	}
	.pro>.pro_text{
		float: right;
		margin-top: 30px;
		height: 130px;
		width: 140px;
		line-height: 25px;
	}
	.pro_text>p{
		margin-bottom: 10px;
	}
	.pro_text>p:first-child{
		color: red;
		font-weight: 900;
	}
	.pro_text>p:nth-child(2){
		font-size: 13px;
	}
	.pro_text>p:nth-child(3){
		font-size: 12px;
		color: #999;
	}
	.pro>.add_btn{
		float: right;
		position: absolute;
		bottom: 15px;
		right: 20px;
	}
	.add_btn>a button{
    padding: 0;
		width: 90px;
		height: 30px;
    outline: none;

    display: flex;
    justify-content: center;
    align-items: center;
	}
</style>
