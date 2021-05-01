<template>
  <div id="infomation-panel" >
    <h3 style="padding-top:10px;">
      <i class="el-icon-news"></i> 更新履歴
    </h3>
    <el-tabs :tab-position="tabPosition" style="height: 350px;" type="border-card">
      <el-tab-pane label="2021-05" class="panel" >
        <b> 05月01日 </b>
         <li>ヘッダー追加</li>
         <li>更新履歴表示機能を追加</li>
      </el-tab-pane>
      <el-tab-pane label="2021-04" class="panel">
        <b> 04月24日 </b>
        <li>テスト表示</li>
        <li>テスト表示</li>
        <li>テスト表示</li>
        <li>テスト表示</li>
        <li>テスト表示</li>
        <li>テスト表示</li>
        <li>テスト表示</li>
        <li>テスト表示</li>
        <li>テスト表示</li>
        <li>テスト表示</li>
        <b> 04月23日 </b>
        <li>テスト表示</li>
        <li>テスト表示</li>
        <li>テスト表示</li>
        <li>テスト表示</li>
        <li>テスト表示</li>
        <li>テスト表示</li>
        <li>テスト表示</li>
        <li>テスト表示</li>
        <li>テスト表示</li>
        <li>テスト表示</li>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script lang="ts">
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
import { Component, Vue } from 'vue-property-decorator';

Vue.use(ElementUI);

@Component
export default class InfomationPanel extends Vue {
  private tabPosition = "left"
}
</script>

<style scoped>
  .panel{
    overflow: scroll; 
    height: 330px;
  }
</style>
