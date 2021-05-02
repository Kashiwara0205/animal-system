import Vue from 'vue/dist/vue.esm.js'
import Animals from "../components/animals/animals"

new Vue({
  el: '#animals',
  components: {
    "animals": Animals
  },
});