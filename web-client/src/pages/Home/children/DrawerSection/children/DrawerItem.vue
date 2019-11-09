<template>
  <div class="pro_item">
    <h4 class="item_title"><span>西二商城自营店</span><span class="item_one">{{goods.price / 100 | moneyFormat}}</span></h4>
    <div class="item_content">
      <div class="pro_Chk">
        <input type="checkbox" class="pro_ChkElem" :checked="goods.checked" @click="singleSelected(goods)">
      </div>
      <div class="item-pic">
        <img :src="goods.thumb_url"/>
      </div>
      <div class="item-info">{{goods.goods_name}}</div>
        <div class="item-amout">
          <el-input-number size="mini" v-model="goods.buy_count" :min="0" :max="goods.counts" @change="updateGoodsCount(goods, goods.buy_count)"></el-input-number>
        </div>
      <div class="item-sum"><strong>{{goods.buy_count * goods.price /100 | moneyFormat}}</strong></div>
    </div>
  </div>
</template>

<script>
  import {mapState} from 'vuex'

  export default {
    props: {
      goods: {
        type: Object,
        required: true
      }
    },
    computed: {
      ...mapState(['userInfo']),
    },
    methods:{
      // 更新单个商品数量
      updateGoodsCount(goods, count){
        let user_id = this.userInfo.id;
        if(count === 0){
          // 是否删除
          this.$confirm('是否删除该商品?', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }).then(() => {
            this.$store.dispatch('delSingleGoods', {goods, user_id});
            this.$message({
              type: 'success',
              message: '删除成功!'
            });
          }).catch(() => {
            this.$store.dispatch('updateGoodsCount', {goods, count: 1, user_id});
            this.$message({
              type: 'info',
              message: '已取消删除'
            });
          });
          return;
        }
        this.$store.dispatch('updateGoodsCount', {goods, count, user_id});
        this.$emit('computeShopCar');
      },
      // 单个商品的选中与否
      singleSelected(goods){
        this.$store.dispatch('singleSelected', {goods});
        this.$emit('computeShopCar');
      },
    },
  }
</script>

<style scoped>
	.pro_item{
		width: 100%;
		height: 90px;
		margin-bottom: 15px;
	}
	.pro_item>.item_title{
		padding: 0 15px;
		width: 100%;
		font-size: 12px;
    color: #666666;
		background: white;
    box-sizing: border-box;

    display: flex;
    align-items: center;
    justify-content: space-between;
	}
	.pro_item>.item_content{
		width: 100%;
		height: 60px;
		background: #f6f6f6;
    box-sizing: border-box;

    display: flex;
    align-items: center;
	}
	.item_content>.pro_Chk{
    flex: 2;

    display: flex;
    justify-content: center;
    align-items: center;
	}
	.item_content div{
    flex: 7;

    display: flex;
    align-items: center;
	}
	.item-pic{
		flex: 3;

    display: flex;
    justify-content: center;
    align-items: center;
	}
	.item-pic img{
		width: 45px;
		height: 45px;
	}
	.item-info{
		flex: 6;
		font-size: 12px;
		color: #999;
		overflow: hidden;
		text-overflow: ellipsis;
    -webkit-clamp: 2;

    display: flex;
    justify-content: center;
	}
	.item-amout{
    flex: 3;

    display: flex;
    justify-content: center;
	}
  .item-amout .el-input-number{
    width: 95px;
  }
	.item-sum{
		flex: 3;

    display: flex;
    justify-content: center;
    align-items: center;
	}
	.item-sum>strong{
		color: #f40;
		font-size: 13px;
	}
</style>
