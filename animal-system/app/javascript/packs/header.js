import Vue from 'vue/dist/vue.esm.js'
import 'element-ui/lib/theme-chalk/index.css';
import Header from "../components/header/header"

new Vue({
  el: '#header',
  components: {
    "animal-system-header": Header
  }
});