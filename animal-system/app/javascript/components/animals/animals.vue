<template>
  <div id="base" v-loading.fullscreen.lock="!completeInit" element-loading-text="Loading...">
    <div v-if="completeInit">
      <h1 class="title"> <i class="el-icon-document"></i> {{ title }} </h1>

      <search-panel v-bind.sync="query"
        @search="fetchInfo"
        :animalTypeList = "animalTypeList"
        :countoryList = "countoryList"
        v-bind:offset.sync="offset"
      >
      </search-panel>

      <list-panel
        @fetchInfo="fetchInfo"
        :info = "info"
        :loading = "loading"
        :animalTypeList = "animalTypeList"
        :countoryList = "countoryList"
        :total = "total"
        v-bind:offset.sync="offset"
      >
      </list-panel>
      
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';
import SearchPanel from "../animals/search_panel/search_panel.vue"
import ListPanel from "../animals/list_panel/list_panel.vue"
import Pagination from "../utils/pagination.vue"
import Animal from "../../model/animal"
import AnimalType from "../../model/animal_type"
import Countory from "../../model/countory"
import http from '../../lib/http'
import notifier from '../../lib/notifier' 
import utils from "../../lib/utils"

@Component({
  components:{ 
    "list-panel": ListPanel,
    "search-panel": SearchPanel,
  }
})
export default class Animals extends Vue {
  private title = "動物情報 一覧"

  private animal = new Animal
  private animalType = new AnimalType
  private countory = new Countory

  private info = []
  private animalTypeList = []
  private countoryList = []

  private total = 0
  private offset = 0

  private query = {
    name_cont: "",
    animal_type_id_eq: "",
    countory_id_eq: "",
    hair_eq: ""
  }

  private loading = false
  private completeInit = false

  created(){ this.fetchInitialInfo() }

  // 初期描画の時のみ使用
  async fetchInitialInfo(){
    this.completeInit = false

    try{
      const url = this.animal.getListUrl()
      const params = { offset: this.offset, limit: 50, query: this.query }

      const animalTypeUrl = this.animalType.getListUrl()
      const countoryUrl = this.countory.getListUrl()

      const requestList = [
        { url: url, params: params }, 
        { url: animalTypeUrl, params: {} },
        { url: countoryUrl, params: {} },
      ]
      
      const res = await http.getAll(requestList);

      this.info = res[0]["data"]["info"]
      this.total = res[0]["data"]["count"]

      this.animalTypeList = res[1]["data"]
      this.countoryList = res[2]["data"]

    }catch(e){
      notifier.notifyError(this)
    }finally{
      this.completeInit = true
      this.loading = false
    }
  }

  // 検索時や更新時に使用
  async fetchInfo(){
    this.loading = true

    try{
      const url = this.animal.getListUrl()
      const params = { offset: this.offset, limit: 50, query: this.query }

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
.panel{
  overflow: scroll; 
  height: 500px;
}

.title{
  padding-left: 15px; 
  margin-top: 10px;
  margin-bottom: 10px;
}
</style>
