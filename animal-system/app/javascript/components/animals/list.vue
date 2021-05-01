<template>
  <div id="list">
  <el-table
    :data="info"
    height="500"
    v-loading="loading"
    border
    style="width: 100%;">
    <el-table-column label="動物名" prop="name"></el-table-column>
    <el-table-column label="種類" prop="type_name"></el-table-column>
    <el-table-column label="体重" prop="weight"></el-table-column>
    <el-table-column label="身長" prop="height"> </el-table-column>
    <el-table-column label="体毛" prop="hair"></el-table-column>
    <el-table-column label="大きさの分類" prop="body"> </el-table-column>
    <el-table-column label="原産国" prop="countory_name"></el-table-column>
    <el-table-column label="登録日時" prop="created_at"> </el-table-column>
    <el-table-column label="更新日時" prop="updated_at"> </el-table-column>
  </el-table>
    
  </div>
</template>

<script lang="ts">
import { Component, Vue, Prop } from 'vue-property-decorator';
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';

Vue.use(ElementUI);

@Component
export default class List extends Vue {
  @Prop({ required: true }) info
  @Prop({ required: true }) loading
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
