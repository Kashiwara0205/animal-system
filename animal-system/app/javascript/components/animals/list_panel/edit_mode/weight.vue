<template>
  <div id="animal_type" >
    <div v-if="editMode">
      <el-link type="primary" @click="onClick">{{ formatWeight(weight) }}</el-link>
    </div>
    <div v-else>
      {{ formatWeight(weight) }}
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Vue, Prop, Watch } from 'vue-property-decorator';
import http from '../../../../lib/http'
import notifier from '../../../../lib/notifier' 

@Component
export default class Weight extends Vue {
  @Prop({ required: true }) id
  @Prop({ required: true }) url
  @Prop({ required: true }) editMode
  @Prop({ required: true }) weight

  private formatWeight(value){
    return `${value}kg`
  }

  private onClick(){
    this.$prompt('体重を入力してください', '体重', {
      inputValue: this.weight,
      confirmButtonText: '編集',
      cancelButtonText: 'キャンセル',
        }).then(({ value }) => {
          this.onSubmit(value)
        })
  }

  private async onSubmit(val){
    try{
      const params = {
        id: this.id,
        update_info:{ weight: val }
      }

      const res = await http.put(this.url, params)
      const record = res.data.updated_record
      this.$emit('update:weight', record["weight"] )
      this.$emit('update:updatedAt', record["updated_at"] )

      notifier.notifySuccess(this, {title: "更新成功", message: "体重を更新しました"})
    }catch(e){
      notifier.notifyError(this)
    }
  }
}
</script>

<style scoped>
</style>
