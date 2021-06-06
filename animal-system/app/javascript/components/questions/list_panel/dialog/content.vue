<template>
  <div>
    <el-dialog
      title="質問内容"
      :visible.sync="dialogVisible"
      width="50%"
      :before-close="onClose">
      <p> 質問者: {{memberName}}</p>
      <p> タイトル: {{title}}</p>
      <br>
      <p> 質問内容: </p>
      <div v-html="fomrtHTML(content)"></div>
      <span slot="footer" class="dialog-footer">
        <el-button @click="onClose">閉じる</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script lang="ts">
import { Component, Vue, Prop, Watch } from 'vue-property-decorator';

@Component
export default class ContentDialog extends Vue {
  @Prop({ required: true }) memberName
  @Prop({ required: true }) title
  @Prop({ required: true }) content
  @Prop({ required: true }) dialogVisible

  private onClose(){
    this.$emit("update:dialogVisible", false)
  }

  private fomrtHTML(content){
    return content.replace("\n", "<br>")
  }
}
</script>

<style scoped>
</style>