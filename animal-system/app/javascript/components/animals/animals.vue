<template>
  <div id="base">
    <h1> {{ title }} </h1>
    <list :model="model"></list>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';
import List from "../animals/list.vue"
import Animal from "../../model/animal"

@Component({
  components:{ list: List }
})
export default class Animals extends Vue {
  private title = "動物情報 一覧"
  private model = new Animal
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
