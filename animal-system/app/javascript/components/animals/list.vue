<template>
  <div id="list">
    <h1> List </h1>
  </div>
</template>

<script lang="ts">
import { Component, Vue, Prop } from 'vue-property-decorator';
import Animal from "../../model/animal"

@Component
export default class List extends Vue {
  @Prop({ required: true }) model: Animal

  created(){
    console.log(this.model.getListUrl())
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
