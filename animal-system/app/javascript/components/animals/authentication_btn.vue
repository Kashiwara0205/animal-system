<template>
  <div>
    <el-button size="mini" type="warning" @click="onClick" class="authentication-btn"> <i class="el-icon-warning"></i>  権限情報 </el-button>
    <el-dialog title="権限情報に関して" :visible.sync="dialogTableVisible" width="80%">
      <span slot="title"><i class="el-icon-warning"></i> 権限情報</span>
      <el-table :data="list" border>
        <el-table-column property="name" label="機能名"></el-table-column>
        <el-table-column property="description" label="説明" ></el-table-column>
        <el-table-column property="authority" label="権限"></el-table-column>
      </el-table>
    </el-dialog>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';

@Component
export default class AuthenticationBtn extends Vue {

  private dialogTableVisible = false
  private list = [
    { name: "追加機能", description: "動物データを追加する機能", authority: "リーダ以上が可能" },
    { name: "編集機能", description: "動物データを編集する機能", authority: "リーダ以上が可能"},
    { name: "検索機能", description: "動物データを検索する機能", authority: "誰でも可能"},
    { name: "編集モード", description: "一覧にて、データを編集出来るようにする機能", authority: "リーダ以上が可能"},
  ]

  onClick(){ this.dialogTableVisible = true }
}
</script>

<style scoped>
  .el-dialog__body{
    padding-top:15px;
  }
  .authentication-btn{
    margin-bottom: 10px; 
  }
</style>