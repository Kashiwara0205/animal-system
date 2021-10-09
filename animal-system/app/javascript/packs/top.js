import Vue from 'vue/dist/vue.esm.js'
import Top from "../components/top/top"
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';

Vue.use(ElementUI);

new Vue({
  el: '#top',
  components: {
    "top": Top
  }
});