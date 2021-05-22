<template>
  <div id="animal_type" >
    <div v-if="editMode">
      <el-link type="primary" @click="onClick">{{ name }}</el-link>
    </div>
    <div v-else>
      {{ name }}
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Vue, Prop, Watch } from 'vue-property-decorator';
import http from '../../../../lib/http'
import notifier from '../../../../lib/notifier' 

@Component
export default class AnimalName extends Vue {
  @Prop({ required: true }) id
  @Prop({ required: true }) url
  @Prop({ required: true }) editMode
  @Prop({ required: true }) name

  private onClick(){
    this.$prompt('動物名を入力してください', '動物名', {
      inputValue: this.name,
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
        update_info:{ name: val }
      }

      const res = await http.put(this.url, params)
      const record = res.data.updated_record
      this.$emit('update:name', record["name"] )
      this.$emit('update:updatedAt', record["updated_at"] )

      notifier.notifySuccess(this, {title: "更新成功", message: "動物名を更新しました"})
    }catch(e){
      notifier.notifyError(this)
    }
  }
}
</script>

<style scoped>
</style>
