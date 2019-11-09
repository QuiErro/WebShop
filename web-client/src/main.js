import Vue from 'vue'
import App from './App'
import store from './store'

// 引入路由器
import router from './router/index'

import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
Vue.use(ElementUI);

// 配置图片懒加载
import VueLazyload from 'vue-lazyload'
import loading from './common/img/loading.gif'
Vue.use(VueLazyload, {
  loading
});

// 引入全局过滤器
import '@/config/filters'

import 'bootstrap/dist/css/bootstrap.css'

new Vue({
  el:'#app',
  router,
  store,
  render: h=>h(App)
});
