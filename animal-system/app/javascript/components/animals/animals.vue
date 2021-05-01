<template>
  <div id="base">
    <h1 style="padding-left: 15px;"> {{ title }} </h1>
    <pagination v-bind:offset.sync="offset" :total="total" @fetchInfo="fetchInfo"> </pagination>
    <list :info="info" :loading="loading" :animal-type-to-ja="animalTypeToJa" :countory-list-to-ja="countoryListToJa" ></list>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';
import List from "../animals/list.vue"
import Pagination from "../utils/pagination.vue"
import Animal from "../../model/animal"
import AnimalType from "../../model/animal_type"
import Countory from "../../model/countory"
import http from '../../lib/http'
import notifier from '../../lib/notifier' 
import utils from "../../lib/utils"

@Component({
  components:{ 
    list: List,
    pagination: Pagination
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

  private animalTypeToJa = {}
  private countoryListToJa = {}

  private total = 0
  private offset = 0
  private query = {}
  private loading = false

  created(){ this.fetchInitInfo() }

  // 初期描画の時のみ使用
  async fetchInitInfo(){
    this.loading = true

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

      this.animalTypeToJa = utils.createNameToJaNameHash( this.animalTypeList )
      this.countoryListToJa = utils.createNameToJaNameHash( this.countoryList )

    }catch(e){
      notifier.notifyError(this)
    }finally{
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
</style>
