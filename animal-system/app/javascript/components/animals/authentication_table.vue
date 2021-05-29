<template>
  <div>
  <h1 class="title"> <i class="el-icon-warning"></i> 権限情報 </h1> 
    <el-table :data="list" border>
      <el-table-column property="name" label="機能名"></el-table-column>
      <el-table-column property="description" label="説明" ></el-table-column>
      <el-table-column property="authority" label="権限"></el-table-column>
    </el-table>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';

@Component
export default class AuthenticationBtn extends Vue {
  private list = [
    { name: "追加機能", description: "動物データを追加する機能", authority: "リーダ以上が可能" },
    { name: "編集機能", description: "動物データを編集する機能", authority: "リーダ以上が可能"},
    { name: "検索機能", description: "動物データを検索する機能", authority: "誰でも可能"},
    { name: "編集モード", description: "一覧にて、データを編集出来るようにする機能", authority: "リーダ以上が可能"},
  ]
}
</script>

<style scoped>
.title{
  margin-bottom: 15px;
}
</style>