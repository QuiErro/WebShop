<template>
  <div id="app">
	<HeaderTop v-show="$route.meta.showHeaderTop"/>
  <HeaderSearch v-show="$route.meta.showHeaderSearch"/>
	<keep-alive>
      <router-view></router-view>
    </keep-alive>
  </div>
</template>

<script>
  import HeaderTop from './components/HeaderTop/HeaderTop'
  import HeaderSearch from './components/HeaderSearch/HeaderSearch'
  import {mapActions} from 'vuex'

  export default {
    name: "App",
    mounted(){
      let userInfo = JSON.parse(window.localStorage.getItem("userInfo"));
      console.log(userInfo);
      if(userInfo){
        this.syncUserInfo(userInfo);
      }
    },
    methods: {
      ...mapActions(['syncUserInfo']),
    },
    components:{
      HeaderTop,
      HeaderSearch
    },
  }
</script>

<style scoped lang="stylus" ref="stylesheet/stylus">
  #app
    width 100%
    height 100%
    position relative
</style>
