<template>
  <div id="hair" >
    <div v-if="editMode">
      <wrap-select :value="hair" @change="onUpdate" itemName="value" :selectList="hairList"></wrap-select>
    </div>
    <div v-else>
      {{ formatHair(hair) }}
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
export default class Hair extends Vue {
  @Prop({ required: true }) id
  @Prop({ required: true }) url
  @Prop({ required: true }) hairToLabel
  @Prop({ required: true }) editMode
  @Prop({ required: true }) hairList
  @Prop({ required: true }) hair

  private formatHair(value){
    if (value in this.hairToLabel) { return this.hairToLabel[value] }
    return value
  }

  async onUpdate(val){
    try{
      const params = {
        id: this.id,
        update_info:{ hair: val }
      }

      const res = await http.put(this.url, params)
      const record = res.data.updated_record
      this.$emit('update:hair', record["hair"] )
      this.$emit('update:updatedAt', record["updated_at"] )
      notifier.notifySuccess(this, {title: "更新成功", message: "体毛を更新しました"})
    }catch(e){
      notifier.notifyError(this)
    }
  }
}
</script>

<style scoped>
</style>
