<template>
  <div>
    <el-dialog
      title="質問内容"
      @update:visible='dialogVisible = $event'
      :visible="dialogVisible"
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
export default {
  props:{
    memberName: String,
    title: String,
    content: String,
    dialogVisible: Boolean
  },

  methods:{
    onClose: function(){
      this.$emit("update:dialogVisible", false)
    },

    fomrtHTML: function(content){
      return content.replace("\n", "<br>")
    }
  }
}
</script>

<style scoped>
</style>