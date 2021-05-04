<template>
  <div id="list" >
    <el-table
      :data="animals"
      @hook:mounted="complete"
      height="500"
      v-loading="tableLoading"
      element-loading-text="Loading..."
      border
      style="width: 100%;">
      <el-table-column label="動物名" prop="name"></el-table-column>
      <el-table-column label="種類">
        <template slot-scope="scope">
          <animal-type 
            :id="scope.row.id"
            :url="animalModel.getUpdateUrl()"
            :animal-type-to-label="animalTypeToLabel"
            :editMode="editMode"
            :animal-type-list="animalTypeList"
            v-bind:animalTypeId.sync="scope.row.animal_type_id">
          </animal-type>
        </template>
      </el-table-column>
      <el-table-column label="原産国">
        <template slot-scope="scope">
          <countory 
            :url="animalModel.getUpdateUrl()"
            :countory-to-label="countoryToLabel"
            :editMode="editMode"
            :countory-list="countoryList"
            :countory-id="scope.row.countory_id">
          </countory>
        </template>
      </el-table-column>
      <el-table-column label="体重" prop="weight" :formatter="formatWeight"></el-table-column>
      <el-table-column label="身長" prop="height" :formatter="formatHeight"> </el-table-column>
      <el-table-column label="体毛">
        <template slot-scope="scope">
          <hair 
            :url="animalModel.getUpdateUrl()"
            :hair-to-label="hairToLabel"
            :editMode="editMode"
            :hair-list="hairList"
            :hair="scope.row.hair">
          </hair>
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
import AnimalType from "../update_component/animal_type.vue"
import Countory from "../update_component/countory.vue"
import Hair from "../update_component/hair.vue"
import utils from "../../../../lib/utils"
import { HAIR_LIST } from "../../../../const"
import moment from 'moment/moment'
Vue.use(ElementUI);

@Component({
  components:{ 
    "animal-type": AnimalType,
    "countory": Countory,
    "hair": Hair
  }
})
export default class List extends Vue {
  @Prop({ required: true }) animalModel
  @Prop({ required: true }) info
  @Prop({ required: true }) editMode
  @Prop({ required: true }) fetchLoading
  @Prop({ required: true }) animalTypeList
  @Prop({ required: true }) countoryList

  private tableLoading = false
  private animals = []
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

  // 編集モードに切り替わった後にlazyLoadを作動
  @Watch("editMode")
  private change(){
    this.lazyLoad(JSON.parse(JSON.stringify(this.animals)))
  }

  // fetchのloading処理が終わった後にlazyLoadを作動
  @Watch("fetchLoading")
  private complete(val){
    if(!val){ this.lazyLoad(JSON.parse(JSON.stringify(this.info))) }
  }

  private lazyLoad(copyInfo){
    const self = this;
    this.animals = [];
    this.tableLoading = true

    const load = function*()  {
      while (true) {
          const items = copyInfo.splice(0, 10);
          if (items.length <= 0){
            self.tableLoading = false
            break
          }
          yield setTimeout(() => {
            for (let len = items.length, i = 0; i < len; i++) {
              const item = items[i]
              self.animals.push(item)
            }
            load.next()
          })
        }
    }()

    load.next()
  }

  private formatDatetime(row, col, value, index){
    return moment(value).format("YYYY-MM-DD HH:mm")
  }
}
</script>

<style scoped>
</style>
