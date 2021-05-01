<template>
  <div id="base">
    <h1> {{ title }} <i class="el-icon-s-tools"></i></h1>
    <infomation-panel></infomation-panel>
    <br>
    ※ 新機能や設計の実験用に開発している架空の企業の社内システムです
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';
import InfoMationPanel from "../top/infomation-panel.vue"

@Component({
  components:{ "infomation-panel": InfoMationPanel }
})
export default class Top extends Vue {
  private title = "動物事業管理システム"
}
</script>

<style scoped>
</style>
