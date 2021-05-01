<template>
  <div id="list">
  <el-table
    :data="info"
    height="500"
    v-loading="loading"
    border
    style="width: 100%;">
    <el-table-column label="動物名" prop="name"></el-table-column>
    <el-table-column label="種類" prop="type_name" :formatter="formatAnimalType"></el-table-column>
    <el-table-column label="原産国" prop="countory_name" :formatter="formatCountory"></el-table-column>
    <el-table-column label="体重" prop="weight" :formatter="formatWeight"></el-table-column>
    <el-table-column label="身長" prop="height" :formatter="formatHeight"> </el-table-column>
    <el-table-column label="体毛" prop="hair" :formatter="formatHair"></el-table-column>
    <el-table-column label="大きさ(種別)" prop="body" :formatter="formatBody"> </el-table-column>
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
  @Prop({ required: true }) animalTypeToJa
  @Prop({ required: true }) countoryListToJa

  private formatHeight(row, col, value, index){
    return `${value}cm`
  }

  private formatWeight(row, col, value, index){
    return `${value}kg`
  }

  private formatAnimalType(row, col, value, index){
    return this.animalTypeToJa[value]
  }

  private formatCountory(row, col, value, index){
    return this.countoryListToJa[value]
  }

  private formatHair(row, col, value, index){
    return {
      "none": "無し",
      "short": "短め",
      "long": "長め"
    }[value]
  }

  private formatBody(row, col, value, index){
    return {
      "small": "小さい",
      "middle": "中くらい",
      "large": "大きい"
    }[value]
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
