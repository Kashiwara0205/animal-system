<template>
  <div id="base" v-loading.fullscreen.lock="!completeInit" element-loading-text="Loading...">
    <div v-if="completeInit">
      <h1 style="padding-left: 15px;"> <i class="el-icon-document"></i> {{ title }} </h1>

      <el-tabs type="border-card">
      <el-tab-pane>
        <span slot="label"><i class="el-icon-document"></i> 一覧表示</span>
        <pagination v-bind:offset.sync="offset" :total="total" @fetchInfo="fetchInfo" disp-message> </pagination>
        <list :info="info" 
              :loading="loading" 
              :animal-type-list="animalTypeList" 
              :countory-list="countoryList" >
        </list>
      </el-tab-pane>
      <el-tab-pane class="panel">  
        <span slot="label"><i class="el-icon-warning"></i> 権限情報</span>
        <b> 種類更新機能  </b> <b style="color:red"> [ 操作可能 ] </b>
        <li> 部署「事務」に所属する者は可能 </li>
        <li> 職位「リーダー」以上の権限を持つ者は可能 </li>

        <br>
        <b> 原産国更新機能 </b> <b style="color:red"> [ 操作可能 ] </b>
        <li> 部署「事務」に所属する者は可能 </li>
        <li> 職位「リーダー」以上の権限を持つ者は可能 </li>
        <br>
        <b> 体毛更新機能 </b>
        <li> ○○さんのみ可能 </li>
      </el-tab-pane>
    </el-tabs>
    </div>
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

  private total = 0
  private offset = 0
  private query = {}

  private loading = false
  private completeInit = false

  created(){ this.fetchInitInfo() }

  // 初期描画の時のみ使用
  async fetchInitInfo(){
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
</style>
