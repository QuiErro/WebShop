import {
  getHomeCasual,
  getCategory,
  getHomeShopList,
  getRecommendShopList,
  getGoodsDetail,
  getGoodsComment,
  getUserInfo,
  getLogout,
  getCartsGoods,
  deleteGoods,
  changeGoodsCount,
  deleteAllGoods,
  searchKeywords
} from '../api'

import {
  HOME_CASUAL,
  CATEGORY_LIST,
  HOME_SHOP_LIST,
  RECOMMEND_SHOP_LIST,
  GOODS_DETAIL,
  GOODS_COMMENT,
  USER_INFO,
  RESET_USER_INFO,
  CART_GOODS_LIST,
  CHANGE_GOODS_COUNT,
  SELECTED_ALL_GOODS,
  SELECTED_SINGLE_GOODS,
  DEL_SINGLE_GOODS,
  DEL_ALL_GOODS,
  SEARCH_KEYWORDS
} from './mutation-types'

export default {
  // 获取首页的轮播图
  async reqHomeCasual({commit}) {
    const result = await getHomeCasual();
    commit(HOME_CASUAL, {homecasual: result.message})
  },

  // 获取分类数组
  async reqCategory({commit}) {
    const result = await getCategory();
    commit(CATEGORY_LIST, {categoryList: result.message})
  },

  // 获取首页的商品数据
  async reqHomeShopList({commit}) {
    const result = await getHomeShopList();
	commit(HOME_SHOP_LIST, {homeshoplist: result.message});
  },

  // 获取推荐的商品数据
  async reqRecommendShopList({commit}, params) {
    const result = await getRecommendShopList(params);
    commit(RECOMMEND_SHOP_LIST, {recommendshoplist: result.message});
  },

  // 获取商品详细数据
  async reqGoodsDetail({commit}, params) {
      const result = await getGoodsDetail(params);
      commit(GOODS_DETAIL, {goodsDetail: result.message});
  },

  // 获取商品评论
  async reqGoodsComment({commit},params) {
    const result = await getGoodsComment(params);
    commit(GOODS_COMMENT, {goodsComment: result.message});
  },

  // 同步用户的信息
  syncUserInfo({commit}, userInfo){
    commit(USER_INFO, {userInfo});
  },

  // 异步获取用户信息
  async getUserInfo({commit},params){
    const result = await getUserInfo(params);
    if(result.success_code === 200){
       commit(USER_INFO, {userInfo: result.message});
       window.localStorage.setItem("userInfo",JSON.stringify(result.message));
    }
  },

  // 退出登录
  async logOut({commit}){
    const result = await getLogout();
    console.log(result);
    if(result.success_code === 200){
      commit(RESET_USER_INFO);
    }
  },

  // 请求购物车数据
  async reqCartsGoods({commit},params) {
    const result = await getCartsGoods(params);
    if(result.success_code === 200){
      commit(CART_GOODS_LIST, {cartgoods: result.message})
    }
  },

  // 单个商品数量的改变
  async updateGoodsCount({commit}, {goods, count, user_id}){
    const result = await changeGoodsCount(goods.goods_id, count, user_id);
    if(result.success_code === 200){
      commit(CHANGE_GOODS_COUNT, {goods,count});
    }
  },

  // 是否选中所有商品
  selectedAll({commit}, {isSelectedAll}){
    console.log(isSelectedAll);
    commit(SELECTED_ALL_GOODS, {isSelectedAll});
  },

  // 是否选中单个商品
  singleSelected({commit}, {goods}){
    commit(SELECTED_SINGLE_GOODS, {goods});
  },

  // 删除单个商品
  async delSingleGoods({commit}, {goods, user_id}){
    const result = await deleteGoods(goods.goods_id, user_id);
    if(result.success_code === 200){
      commit(DEL_SINGLE_GOODS, {goods});
    }
  },

  // 删除所有商品
  async delAllGoods({commit}, {user_id}){
    const result = await deleteAllGoods(user_id);
    if(result.success_code === 200){
      commit(DEL_ALL_GOODS);
    }
  },

  // 模糊搜索
  async reqSearch({commit}, {keywords}){
    const result = await searchKeywords(keywords);
    if(result.success_code === 200){
      let searchresults = result.message;
      commit(SEARCH_KEYWORDS, {searchresults});
    }
  }
}
