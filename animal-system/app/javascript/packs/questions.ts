import Vue from 'vue/dist/vue.esm.js'
import Questions from "../components/questions/questions.vue"

new Vue({
  el: '#questions',
  components: {
    "questions": Questions
  },
});