<template>
  <div id="animal_type" >
    <div v-if="editMode">
      <wrap-select :value="animalTypeId" @change="onUpdate" itemName="id" :selectList="animalTypeList"></wrap-select>
    </div>
    <div v-else>
      {{ formatAnimalType(animalTypeId) }}
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
export default class AnimalType extends Vue {
  @Prop({ required: true }) id
  @Prop({ required: true }) url
  @Prop({ required: true }) animalTypeToLabel
  @Prop({ required: true }) editMode
  @Prop({ required: true }) animalTypeList
  @Prop({ required: true }) animalTypeId

  private formatAnimalType(value){
    if (value in this.animalTypeToLabel) { return this.animalTypeToLabel[value] }
    return value
  }

  async onUpdate(val){
    try{
      const params = {
        id: this.id,
        update_info:{ animal_type_id: val }
      }

      const res = await http.put(this.url, params)
      const record = res.data.updated_record
      this.$emit('update:animalTypeId', record["animal_type_id"] )
      this.$emit('update:updatedAt', record["updated_at"] )
      notifier.notifySuccess(this, {title: "更新成功", message: "種類を更新しました"})
    }catch(e){
      if (422 === e.response.status){
        notifier.notifyError(this, "更新に失敗しました", e.response.data.errors[0])
      }else{
        notifier.notifyError(this)
      }
    }
  }

}
</script>

<style scoped>
</style>
