<template>
  <div id="countory" >
    <div v-if="editMode">
      <wrap-select :value="countoryId" itemName="id" :selectList="countoryList"></wrap-select>
    </div>
    <div v-else>
      {{ formatCountory(countoryId) }}
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
export default class Countory extends Vue {
  @Prop({ required: true }) countoryToLabel
  @Prop({ required: true }) editMode
  @Prop({ required: true }) countoryList
  @Prop({ required: true }) countoryId

  private formatCountory(value){
    if (value in this.countoryToLabel) { return this.countoryToLabel[value] }
    return value
  }
}
</script>

<style scoped>
</style>
