<template>
  <div id="list">
    <h1> List </h1>
  </div>
</template>

<script lang="ts">
import Animal from "../../model/animal"

export default {
  props:{
    model: Animal
  },
  data: function () {
    return {
      title: "動物情報 一覧"
    }
  },

  created: function(){
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
