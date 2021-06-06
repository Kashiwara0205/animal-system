<template>
  <div>

    <el-tabs type="border-card">
      <el-tab-pane>
        <span slot="label"><i class="el-icon-document"></i> 一覧表示</span>

        <pagination v-bind:offset.sync="paginationOffset" :total="total" @fetchInfo="fetchInfo" disp-message> </pagination>

        <list :info="info" 
              :phase-list="phaseList"
              :fetchLoading="loading" 
              @fetchInfo="fetchInfo" >
        </list>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script lang="ts">
import { Component, Vue, Prop } from 'vue-property-decorator';
import List from "../list_panel/list.vue"
import Pagination from "../../utils/pagination.vue"

@Component({
  components:{ 
    list: List,
    pagination: Pagination,
  }
})
export default class Panel extends Vue {
  @Prop({ required: true }) questionModel
  @Prop({ required: true }) phaseList
  @Prop({ required: true }) info
  @Prop({ required: true }) loading
  @Prop({ required: true }) total
  @Prop({ required: true }) offset

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