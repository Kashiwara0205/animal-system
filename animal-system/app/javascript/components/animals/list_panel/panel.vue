<template>
  <div>

    <register-form 
      v-if="registerFormVisible"
      v-bind:register-form-visible.sync="registerFormVisible"
      :url="animalModel.getUpdateUrl()"
      :animal-type-list="animalTypeList"
      :countory-list="countoryList"
      :hair-list="hairList"
      @complete="fetchInfo">
    </register-form>

    <el-tabs type="border-card">
      <el-tab-pane>
        <span slot="label"><i class="el-icon-document"></i> 一覧表示</span>

        <download-btn :query="query" 
                      :url="animalModel.getCsvUrl()"
                      :animal-type-list="animalTypeList" 
                      :countory-list="countoryList"
                      :hair-list="hairList">
        </download-btn>
        <el-button @click="registerFormVisible = true" size="small"> 新規追加 </el-button>
        <el-checkbox v-model="editMode" style="padding-left: 15px; padding-bottom: 15px;"> 編集モード</el-checkbox>

        <pagination v-bind:offset.sync="paginationOffset" :total="total" @fetchInfo="fetchInfo" disp-message> </pagination>

        <list :info="info" 
              :animalModel="animalModel"
              :editMode="editMode"
              :fetchLoading="loading" 
              :animal-type-list="animalTypeList" 
              :countory-list="countoryList"
              :hair-list="hairList"
              @fetchInfo="fetchInfo" >
        </list>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script lang="ts">
import { Component, Vue, Prop } from 'vue-property-decorator';
import List from "../list_panel/list.vue"
import RegisterForm from "../list_panel/form/register_form.vue"
import DownloadBtn from "./download_btn.vue"
import Pagination from "../../utils/pagination.vue"
import { HAIR_LIST } from "../../../const"

@Component({
  components:{ 
    list: List,
    pagination: Pagination,
    "register-form": RegisterForm,
    "download-btn": DownloadBtn
  }
})
export default class ListPanel extends Vue {
  @Prop({ required: true }) animalModel
  @Prop({ required: true }) info
  @Prop({ required: true }) loading
  @Prop({ required: true }) animalTypeList
  @Prop({ required: true }) countoryList
  @Prop({ required: true }) total
  @Prop({ required: true }) offset
  @Prop({ required: true }) query

  private hairList = HAIR_LIST
  private editMode = false
  private paginationOffset = 0
  
  private registerFormVisible = false

  private fetchInfo(){ 
    this.$emit('update:offset', this.paginationOffset)
    this.$emit("fetchInfo") 
  }
}
</script>

<style scoped>
.panel{
  overflow: scroll; 
  height: 500px;
}

</style>