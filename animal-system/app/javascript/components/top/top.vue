<template>
  <div id="base">
    <h1> <i class="el-icon-s-tools"></i> {{ title }}</h1>
    <info-mation-panel></info-mation-panel>
    <br>
    ※ 新機能や設計の実験用に開発している架空の企業の社内システムです
  </div>
</template>

<script lang="ts">
import InfoMationPanel from "../top/infomation-panel.vue"

export default {
  components:{ 
    InfoMationPanel 
  },
  data(){
    return {
      title: "動物事業管理システム"
    }
  }
}
</script>

<style scoped>
</style>
