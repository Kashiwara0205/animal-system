<template>
  <div>
    <el-tabs type="border-card">
      <el-tab-pane>
        <span slot="label"><i class="el-icon-document"></i> 一覧表示</span>

        <el-checkbox v-model="editMode" style="padding-left: 15px; padding-bottom: 15px;"> 編集モード</el-checkbox>

        <pagination v-bind:offset.sync="paginationOffset" :total="total" @fetchInfo="fetchInfo" disp-message> </pagination>

        <list :info="info" 
              :animalModel="animalModel"
              :editMode="editMode"
              :fetchLoading="loading" 
              :animal-type-list="animalTypeList" 
              :countory-list="countoryList" >
        </list>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script lang="ts">
import { Component, Vue, Prop } from 'vue-property-decorator';
import List from "../list_panel/list/list.vue"
import Pagination from "../../utils/pagination.vue"

@Component({
  components:{ 
    list: List,
    pagination: Pagination
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

  private editMode = false
  private paginationOffset = 0

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