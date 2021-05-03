<template>
  <div>
    <el-tabs type="border-card">
      <el-tab-pane>
        <span slot="label"><i class="el-icon-document"></i> 一覧表示</span>

        <el-checkbox v-model="editMode" style="padding-left: 15px; padding-bottom: 15px;"> 編集モード</el-checkbox>

        <pagination v-bind:offset.sync="offset" :total="total" @fetchInfo="fetchInfo" disp-message> </pagination>
        <list :info="info" 
              :editMode="editMode"
              :fetchLoading="loading" 
              :animal-type-list="animalTypeList" 
              :countory-list="countoryList" >
        </list>
      </el-tab-pane>
      <el-tab-pane class="panel">
        <span slot="label"><i class="el-icon-warning"></i> 権限情報</span>
        <authentication-list></authentication-list>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script lang="ts">
import { Component, Vue, Prop } from 'vue-property-decorator';
import List from "../../animals/list_panel/list.vue"
import AuthenticationList from "../../animals/list_panel/authentication_list.vue"
import Pagination from "../../utils/pagination.vue"

@Component({
  components:{ 
    list: List,
    "authentication-list": AuthenticationList,
    pagination: Pagination
  }
})
export default class Table extends Vue {
  @Prop({ required: true }) info
  @Prop({ required: true }) loading
  @Prop({ required: true }) animalTypeList
  @Prop({ required: true }) countoryList
  @Prop({ required: true }) total
  @Prop({ required: true }) offset

  private editMode = false

  private fetchInfo(){ 
    this.$emit('update:offset', this.offset)
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