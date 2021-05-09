<template>
  <div id="animal_type" >
    <div v-if="editMode">
      <el-link type="primary" @click="onClick">{{ formatHeight(height) }}</el-link>
    </div>
    <div v-else>
      {{ formatHeight(height) }}
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Vue, Prop, Watch } from 'vue-property-decorator';
import http from '../../../../lib/http'
import notifier from '../../../../lib/notifier' 

@Component
export default class Height extends Vue {
  @Prop({ required: true }) id
  @Prop({ required: true }) url
  @Prop({ required: true }) editMode
  @Prop({ required: true }) height

  private formatHeight(value){
    return `${value}cm`
  }

  private onClick(){
    this.$prompt('身長を入力してください', '身長', {
      inputValue: this.height,
      confirmButtonText: '編集',
      cancelButtonText: 'キャンセル',
        }).then(({ value }) => {
          this.onSubmit(value)
        }).catch(() => {
          notifier.notifyCancel(this)
        });
  }

  private async onSubmit(val){
    try{
      const params = {
        id: this.id,
        update_info:{ height: val }
      }

      const res = await http.put(this.url, params)
      const record = res.data.updated_record
      this.$emit('update:height', record["height"] )
      this.$emit('update:updatedAt', record["updated_at"] )

      notifier.notifySuccess(this, {title: "更新成功", message: "身長を更新しました"})
    }catch(e){
      notifier.notifyError(this)
    }
  }
}
</script>

<style scoped>
</style>
