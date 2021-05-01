<template>
  <div id="base">
    <h1 style="padding-left: 15px;"> {{ title }} </h1>
    <pagination v-bind:offset.sync="offset" :total="total" @fetchInfo="fetchInfo"> </pagination>
    <list :info="info" :loading="loading"></list>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';
import List from "../animals/list.vue"
import Pagination from "../utils/pagination.vue"
import Animal from "../../model/animal"
import http from '../../lib/http'
import notifier from '../../lib/notifier'

@Component({
  components:{ 
    list: List,
    pagination: Pagination
  }
})
export default class Animals extends Vue {
  private title = "動物情報 一覧"
  private model = new Animal
  private info = []
  private total = 0
  private offset = 0
  private query = {}
  private loading = false

  created(){
    this.fetchInfo()
  }

  async fetchInfo(){
    this.loading = true

    const url = this.model.getListUrl()
    const params = { offset: this.offset, limit: 50, query: this.query }
    try{
      const res = await http.get(url, params);
      this.info = res["data"]["info"]
      this.total = res["data"]["count"]
    }catch(e){
      notifier.notifyError(this)
    }finally{
      this.loading = false
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
