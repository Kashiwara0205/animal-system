<template>
  <div id="base" v-loading.fullscreen.lock="!completeInit" element-loading-text="Loading...">
    <el-tabs type="border-card" class="local-navigation">
      <el-tab-pane label="一覧表示">

        <div v-if="completeInit">
          <h1 class="title"> <i class="el-icon-document"></i> {{ title }} </h1> 

          <search-panel 
            @update:query='query = $event'
            :query="query"
            @update:offset='offset = $event'
            :offset="offset"
            @search="fetchInfo"
            :phase-list = "phaseList">
          </search-panel>

          <list-panel
             @fetchInfo="fetchInfo"
            :question-model="question"
            :info = "info"
            :loading = "loading"
            :total = "total"
            :phase-list = "phaseList"
            @update:offset='offset = $event'
            :offset="offset">
          </list-panel>
        </div>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';
import ListPanel from "../questions/list_panel/panel.vue"
import SearchPanel from "../questions/search_panel/panel.vue"
import Pagination from "../utils/pagination.vue"
import Question from "../../model/question"
import http from '../../lib/http'
import notifier from '../../lib/notifier' 
import utils from "../../lib/utils/common"
import { createQueryForm } from "../../lib/utils/form_builder/question"
import { PHASE_LIST } from "../../const/common"

@Component({
  components:{ 
    ListPanel,
    SearchPanel
  }
})
export default class Questions extends Vue {

  private title = "質問情報 一覧"

  private question = new Question

  private info = []

  private total = 0
  private offset = 0

  private loading = false
  private completeInit = false

  private query = createQueryForm()
  private phaseList = PHASE_LIST

  created(){ this.fetchInitialInfo() }

  // 初期描画の時のみ使用
  async fetchInitialInfo(){
    this.completeInit = false

    try{
      const url = this.question.getListUrl()
      const params = { offset: this.offset, limit: 50, query: this.query }

      const requestList = [
        { url: url, params: params }, 
      ]
      
      const res = await http.getAll(requestList);

      this.info = res[0]["data"]["info"]
      this.total = res[0]["data"]["count"]

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
      const url = this.question.getListUrl()
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
  margin-top: 5px;
}

.local-navigation{
  margin-top: 5px;
}
</style>
