<template>
  <div id="list">
    <el-table
      :data="info"
      height="500"
      v-loading="loading"
      element-loading-text="Loading..."
      border
      style="width: 100%;">
      <el-table-column label="動物名" prop="name"></el-table-column>
      <el-table-column label="種類" :formatter="formatAnimalType">
        <template slot-scope="scope">
          <wrap-select :toLabelHash="animalTypeToLabel" itemName="id" :value="scope.row.animal_type_id" :select-list="animalTypeList" ></wrap-select>
        </template>
      </el-table-column>
      <el-table-column label="原産国" prop="countory_name" :formatter="formatCountory">
        <template slot-scope="scope">
          <wrap-select :toLabelHash="countoryToLabel" itemName="id" :value="scope.row.countory_id" :select-list="countoryList" ></wrap-select>
        </template>
      </el-table-column>
      <el-table-column label="体重" prop="weight" :formatter="formatWeight"></el-table-column>
      <el-table-column label="身長" prop="height" :formatter="formatHeight"> </el-table-column>
      <el-table-column label="体毛" prop="hair">
        <template slot-scope="scope">
          <wrap-select :toLabelHash="hairToLabel" itemName="value" :value="scope.row.hair" :select-list="hairList" ></wrap-select>
        </template>
      </el-table-column>
      <el-table-column label="登録日時" prop="created_at" :formatter="formatDatetime"> </el-table-column>
      <el-table-column label="更新日時" prop="updated_at" :formatter="formatDatetime"> </el-table-column>
    </el-table> 
  </div>
</template>

<script lang="ts">
import { Component, Vue, Prop, Watch } from 'vue-property-decorator';
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
import WrapSelect from "../../utils/wrap-select.vue"
import utils from "../../../lib/utils"
import { HAIR_LIST } from "../../../const"
import moment from 'moment/moment'

Vue.use(ElementUI);

@Component({
  components:{ 
    "wrap-select": WrapSelect
  }
})
export default class List extends Vue {
  @Prop({ required: true }) info
  @Prop({ required: true }) loading
  @Prop({ required: true }) animalTypeList
  @Prop({ required: true }) countoryList

  private hairList = HAIR_LIST

  private animalTypeToLabel = {}
  private countoryToLabel = {}
  private hairToLabel = utils.createValueToLabelHash( HAIR_LIST )

  created(){
   this.animalTypeToLabel = utils.createIdToLabelHash( this.animalTypeList )
   this.countoryToLabel = utils.createIdToLabelHash( this.countoryList )
  }

  private formatHeight(row, col, value, index){
    return `${value}cm`
  }

  private formatWeight(row, col, value, index){
    return `${value}kg`
  }

  private formatAnimalType(row, col, value, index){
    if (value in this.animalTypeToLabel) { return this.animalTypeToLabel[value] }
    return value
  }

  private formatCountory(row, col, value, index){
    if (value in this.countoryToLabel) { return this.countoryToLabel[value] }
    return value
  }

  private formatDatetime(row, col, value, index){
    return moment(value).format("YYYY-MM-DD HH:mm")
  }
}
</script>

<style scoped>
</style>
