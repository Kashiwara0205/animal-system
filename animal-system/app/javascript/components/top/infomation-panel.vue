<template>
  <div id="infomation-panel" >
    <h3 style="padding-top:10px;">
      <i class="el-icon-news"></i> 更新履歴
    </h3>
    <el-tabs :tab-position="tabPosition" style="height: 350px;" type="border-card">
      <el-tab-pane label="2021-05" class="panel" >
        <b> 05月22日 </b>
        <li>登録フォームを追加 <br>

        <li>編集フォームを追加 <br>
             el-formのフロントバリデーションは、結構便利だった。普段の業務でも使えると思う。 <br>
        </li>
        <br>
        <li>動物名、体重、身長にバリデーションを追加 <br>
            el-message-boxのバリデーションは使いにくかった。<br>
            編集を押した後に必ずモーダルが閉じてしまうので使い勝手が悪い。<br>
            サーバー側のエラーを表示する時にモーダルが閉じるので、もう一度開かなければならない<br>
            エラーになるケースが、そんなに発生しないなら使っても大丈夫かも？<br>
            拡張性は低い。ボタン3にするとかは難しそう。<br>
        </li>
        <br>
        <b> 05月09日 </b>
        <li>動物一覧検索機能を追加</li>
        <li>動物一覧に編集モードを追加</li>
        <br>
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
