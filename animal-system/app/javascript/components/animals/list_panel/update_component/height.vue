<template>
  <div id="animal_type" >
    <div v-if="editMode">
      <el-link type="primary" @click="onClick">{{ formatWeight(height) }}</el-link>
    </div>
    <div v-else>
      {{ formatWeight(height) }}
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

  private formatWeight(value){
    return `${value}kg`
  }

  private onClick(){
    console.log("UPD")
  }
}
</script>

<style scoped>
</style>
