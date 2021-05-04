<template>
  <div id="authentication-list">
    <p> ※ 現在割り当てられている権限を表示しています </p>
    <el-table
      :data="info"
      height="500"
      border
      style="width: 100%;">
      <el-table-column label="機能名" prop="name"></el-table-column>
      <el-table-column label="操作可/不可" prop="permission"></el-table-column>
      <el-table-column label="説明" prop="description"></el-table-column>
    </el-table>
  </div>
</template>

<script lang="ts">
import { Component, Vue, Prop, Watch } from 'vue-property-decorator';
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';

Vue.use(ElementUI);

@Component
export default class AuthenticationList extends Vue {
  private info = [
    { name: "更新機能（一覧）", permission: "操作可", description: "職位「リーダー」の者のみ操作可能" },
    { name: "検索機能", permission: "操作可", description: "全ての者が操作可能" }
  ]
}
</script>

<style scoped>
</style>
