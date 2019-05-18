<template>
  <div>
    <div id="container">
      <div class="product">
        <div class="pro_line">
          <router-link to="/home" class="goHome">返回首页</router-link>
        </div>
        <div class="pro_show" v-if="searchresults.length">
          <div class="pro" v-for="(good, index) in searchresults" :key="index">
            <img :src="good.thumb_url" class="pro_img">
            <div class="pro_text">
              <p><em>¥{{good.price / 100 | priceFormat}}</em></p>
              <p>{{ good.short_name }}</p>
              <p>西二商城自营店</p>
            </div>
            <div class="add_btn">
              <a @click="goDetail(good.goods_id)">查看详情</a>
            </div>
          </div>
        </div>
        <div v-else>
          找不到您想要的商品
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import { mapState } from 'vuex'

  export default {
    data(){
      return{
      }
    },
    computed: {
      ...mapState(['searchresults']),
    },
    filters: {
      priceFormat(price) {
        return price.toFixed(2);
      },
    },
    methods:{
      goDetail(id){
        this.$router.replace('/goods/' + id);
      },
    },
  }
</script>

<style scoped>
#container{
	position: relative;
	margin: 30px auto;
	width: 100%;
}
.product{
	margin: 0 auto;
	width: 980px;
}
.product>.pro_line{
	margin-bottom: 20px;
	width: 980px;
	height: 50px;
	line-height: 50px;
	font-size: 26px;
    font-family: sans-serif;
    font-weight: normal;
    color: #222;
}
.pro_line>h3{
	display: inline-block;
}
.el-dropdown-link {
	display: inline-block;
    cursor: pointer;
    color: #409EFF;
}
.el-icon-arrow-down {
    font-size: 12px;
}
.goHome{
	font-size: 14px;
	display: inline-block;
	margin-left: 20px;
	text-decoration: none;
	color: skyblue;
	cursor: pointer;
}
.goHome:hover{
	color: #ccc;
}
.product>.pro_show{
	margin: 0 auto;
	padding-left: 20px;
	width: 980px;
	height: 300px;
}
.pro_show>.pro{
	position: relative;
	float: left;
	margin-right: 20px;
	margin-bottom: 20px;
	width: 300px;
	height: 200px;
	border: 1px solid gainsboro;
}
.pro>.pro_img{
	margin: 20px;
	width: 120px;
	height: 120px;
}
.pro>.pro_text{
	position: absolute;
	top: 30px;
  right: 0;
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
.add_btn>a{
	display: block;
	width: 120px;
	height: 25px;
	text-align: center;
	line-height: 25px;
	background: #FF0036;
	color: white;
	cursor: pointer;
}
#footer{
	height: 50px;
	width: 100%;
	text-align: center;
}
#footer>ul.pagination{
	margin: 0 auto;
	width: 294px;
	height: 36px;
}
ul.pagination li{
	float: left;
}
ul.pagination li a {
    float: left;
    padding: 8px 16px;
    text-decoration: none;
	transition: background-color .3s;
	color: black;
    border: 1px solid #ddd;
}
ul.pagination li a.pag_active {
    background-color: #c40000;
    color: white;
    border: 1px solid #c40000;
}
ul.pagination li a:hover:not(.pag_active){
	background-color: #ddd;
}
div.center{
	text-align: center;
}
</style>
