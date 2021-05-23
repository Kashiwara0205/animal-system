<template>
  <span>
    <el-popconfirm
      confirm-button-text='削除'
      @confirm="onConfirm"
      cancel-button-text='キャンセル'
      icon="el-icon-info"
      icon-color="red"
      :title="title">
      <el-button slot="reference" type="danger" size="mini">削除</el-button>
    </el-popconfirm>
  </span>
</template>

<script lang="ts">
import { Component, Vue, Prop, Watch } from 'vue-property-decorator';
import http from '../../../lib/http'
import notifier from '../../../lib/notifier' 

@Component
export default class DeleteBtn extends Vue {
  @Prop({ required: true }) id
  @Prop({ required: true }) name
  @Prop({ required: true }) url

  get title(){
    return `${this.name}を削除します。よろしいですか？`
  }

  private async onConfirm(val){
    try{
      const params = {
        id: this.id,
        update_info:{ visible: false }
      }

      const res = await http.put(this.url, params)
      const record = res.data.updated_record
      this.$emit("complete")
      notifier.notifySuccess(this, {title: "削除成功", message: `${this.name}を削除しました`})
    }catch(e){
      if (422 === e.response.status){
        notifier.notifyError(this, "削除に失敗しました", e.response.data.errors[0])
      }else{
        notifier.notifyError(this)
      }
    }
  }
}
</script>

<style scoped>
</style>
