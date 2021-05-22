<template>
  <div id="countory" >
    <div v-if="editMode">
      <wrap-select :value="countoryId" @change="onUpdate" itemName="id" :selectList="countoryList"></wrap-select>
    </div>
    <div v-else>
      {{ formatCountory(countoryId) }}
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Vue, Prop, Watch } from 'vue-property-decorator';
import WrapSelect from "../../../utils/wrap-select.vue"
import http from '../../../../lib/http'
import notifier from '../../../../lib/notifier'

@Component({
  components:{ 
    "wrap-select": WrapSelect,
  }
})
export default class Countory extends Vue {
  @Prop({ required: true }) id
  @Prop({ required: true }) url
  @Prop({ required: true }) countoryToLabel
  @Prop({ required: true }) editMode
  @Prop({ required: true }) countoryList
  @Prop({ required: true }) countoryId

  private formatCountory(value){
    if (value in this.countoryToLabel) { return this.countoryToLabel[value] }
    return value
  }

  async onUpdate(val){
    try{
      const params = {
        id: this.id,
        update_info:{ countory_id: val }
      }

      const res = await http.put(this.url, params)
      const record = res.data.updated_record
      this.$emit('update:countoryId', record["countory_id"] )
      this.$emit('update:updatedAt', record["updated_at"] )
      notifier.notifySuccess(this, {title: "更新成功", message: "原産国を更新しました"})
    }catch(e){
      notifier.notifyError(this)
    }
  }
}
</script>

<style scoped>
</style>
