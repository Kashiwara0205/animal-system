<template>
  <div id="animal-system-pagination"> 
    <p v-if="dispMessage" style="padding-left: 10px; margin: 5px;"> {{ total }}件のうち{{offset}}~{{nextOffset}}件を表示 </p>
    <el-pagination
      layout="prev, pager, next"
      @current-change="currentChange"
      :page-size="50"
      :current-page.sync="currentPage"
      :total="total">
    </el-pagination>
  </div>
</template>

<script lang="ts">
import { Component, Vue, Prop, Watch } from 'vue-property-decorator';
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';

Vue.use(ElementUI);

@Component
export default class List extends Vue {
  @Prop({ type: Boolean }) dispMessage
  @Prop({ required: true }) offset
  @Prop({ required: true }) total

  private currentPage = 1

  get nextOffset(){
    const nextOffset = this.currentPage * 50
    if(this.total < nextOffset){ return this.total }
    return nextOffset
  }

  @Watch('offset')
  resetCurrentPage(val) {
    if(0 === val){ this.currentPage = 1 }
  }

  currentChange(idx){
    this.$emit('update:offset', (idx - 1) * 50)
    this.$emit('fetchInfo')
  }
}
</script>

<style>

.btn-next, .btn-prev, .btn-quickprev, .btn-quicknext,
.el-pagination .number,
.el-pagination button:disabled,
.el-pagination .btn-next {
  background:transparent !important;
  font-size: 15px;
}

.btn-next .el-icon, .btn-prev .el-icon  {
font-size: 18px !important;
}
</style>
