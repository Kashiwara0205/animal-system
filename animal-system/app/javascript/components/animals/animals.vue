<template>
  <div id="base">
    <h1> {{ title }} </h1>
    <list :model="model"></list>
  </div>
</template>

<script lang="ts">
import List from "../animals/list.vue"
import Animal from "../../model/animal"

export default {

  components: {
    "list": List
  },

  data: function () {
    return {
      title: "動物情報 一覧",
      model: new Animal
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
