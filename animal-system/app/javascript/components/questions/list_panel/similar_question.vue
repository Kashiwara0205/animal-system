<template>
  <span>
   <el-dialog 
     :title="title" 
     :before-close="onClose" 
     @update:visible='dialogVisible = $event'
     :visible="dialogVisible" >

      <h4> タイトルベースの類似質問 </h4>
      <li v-for="(text, index) in info.titleBase">
        {{ text }}
      </li>

      <h4> 内容ベースの類似質問 </h4>
      <li v-for="(text, index) in info.contentBase">
        {{ text }}
      </li>

      <span slot="footer" class="dialog-footer">
        <el-button @click="onClose()">キャンセル</el-button>
      </span>
    </el-dialog>
  </span>
</template>

<script lang="ts">
import { Component, Vue, Prop, Watch } from 'vue-property-decorator';
import http from '../../../lib/http'

@Component
export default class SimilarQuestion extends Vue {
  @Prop({ required: true }) dialogVisible
  @Prop({ required: true }) id
  @Prop({ required: true }) title

  private info = {
    titleBase: ["", "", ""],
    contentBase: ["", "", ""],
    memberBase: ["", "", ""]
  }

  @Watch("dialogVisible")
  async fetchSimilarQuestion(val){
    if (val){
      const res = await http.get("/api/v1/questions/recommend", {id: this.id})
      const info = res.data.info

      this.info = {
        titleBase: info.title_base,
        contentBase: info.content_base,
        memberBase: info.member_base
      }
    }
  }

  onClose(){
    this.$emit('update:dialogVisible', false)
  }
}
</script>

<style>

.el-dialog__body {
  padding: 15px 20px !important;
}
</style>