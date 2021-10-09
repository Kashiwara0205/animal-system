import Vue from 'vue/dist/vue.esm.js'
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
import Header from "../components/header/header"

Vue.use(ElementUI);

new Vue({
  el: '#header',
  components: {
    "animal-system-header": Header
  }
});

