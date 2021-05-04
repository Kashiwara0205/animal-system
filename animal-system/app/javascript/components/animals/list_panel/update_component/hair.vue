<template>
  <div id="hair" >
    <div v-if="editMode">
      <wrap-select :value="hair" itemName="value" :selectList="hairList"></wrap-select>
    </div>
    <div v-else>
      {{ formatHair(hair) }}
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Vue, Prop, Watch } from 'vue-property-decorator';
import WrapSelect from "../../../utils/wrap-select.vue"

@Component({
  components:{ 
    "wrap-select": WrapSelect,
  }
})
export default class Hair extends Vue {
  @Prop({ required: true }) hairToLabel
  @Prop({ required: true }) editMode
  @Prop({ required: true }) hairList
  @Prop({ required: true }) hair

  private formatHair(value){
    if (value in this.hairToLabel) { return this.hairToLabel[value] }
    return value
  }
}
</script>

<style scoped>
</style>
