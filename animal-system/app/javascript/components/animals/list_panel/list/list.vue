<template>
  <div id="list" >

    <edit-form 
      v-if="editFormVisible"
      v-bind:edit-form-visible.sync="editFormVisible"
      :edit-info="editRow.info"
      :url="animalModel.getUpdateUrl()"
      :animal-type-list="animalTypeList"
      :countory-list="countoryList"
      :hair-list="hairList"
      @updateRow="updateRow"
      >
    </edit-form>

    <el-table
      :data="animals"
      @hook:mounted="complete"
      height="500"
      v-loading="tableLoading"
      element-loading-text="Loading..."
      border
      style="width: 100%;">

      <el-table-column label="動物名">
        <template slot-scope="scope">
          <animal-name
            :id="scope.row.id"
            :url="animalModel.getUpdateUrl()"
            :editMode="editMode"
            v-bind:name.sync="scope.row.name"
            v-bind:updatedAt.sync="scope.row.updated_at">
          </animal-name>
        </template>
      </el-table-column>

      <el-table-column label="種類">
        <template slot-scope="scope">
          <animal-type 
            :id="scope.row.id"
            :url="animalModel.getUpdateUrl()"
            :animal-type-to-label="animalTypeToLabel"
            :editMode="editMode"
            :animal-type-list="animalTypeList"
            v-bind:animalTypeId.sync="scope.row.animal_type_id"
            v-bind:updatedAt.sync="scope.row.updated_at">
          </animal-type>
        </template>
      </el-table-column>

      <el-table-column label="原産国">
        <template slot-scope="scope">
          <countory 
            :id="scope.row.id"
            :url="animalModel.getUpdateUrl()"
            :countory-to-label="countoryToLabel"
            :editMode="editMode"
            :countory-list="countoryList"
            v-bind:countoryId.sync="scope.row.countory_id"
            v-bind:updatedAt.sync="scope.row.updated_at">
          </countory>
        </template>
      </el-table-column>

      <el-table-column label="体重">
        <template slot-scope="scope">
          <weight
            :id="scope.row.id"
            :url="animalModel.getUpdateUrl()"
            :editMode="editMode"
            v-bind:weight.sync="scope.row.weight"
            v-bind:updatedAt.sync="scope.row.updated_at">
          >
          </weight>
        </template>
      </el-table-column>

      <el-table-column label="身長"> 
        <template slot-scope="scope">
          <height
            :id="scope.row.id"
            :url="animalModel.getUpdateUrl()"
            :editMode="editMode"
            v-bind:height.sync="scope.row.height"
            v-bind:updatedAt.sync="scope.row.updated_at">
          >
          </height>
        </template>
      </el-table-column>

      <el-table-column label="体毛">
        <template slot-scope="scope">
          <hair 
            :id="scope.row.id"
            :url="animalModel.getUpdateUrl()"
            :hair-to-label="hairToLabel"
            :editMode="editMode"
            :hair-list="hairList"
            v-bind:hair.sync="scope.row.hair"
            v-bind:updatedAt.sync="scope.row.updated_at">
          </hair>
        </template>
      </el-table-column>
      
      <el-table-column label="登録日時" prop="created_at" :formatter="formatDatetime"> </el-table-column>
      <el-table-column label="更新日時" prop="updated_at" :formatter="formatDatetime"> </el-table-column>
      <el-table-column label="操作" width="150px"> 
        <template slot-scope="scope">
           <el-button size="small" @click="onClickEditBtn(scope.$index, scope.row)">編集</el-button>
          <el-button size="mini" type="danger">削除</el-button>
        </template>
      </el-table-column>
    </el-table> 
  </div>
</template>

<script lang="ts">
import { Component, Vue, Prop, Watch } from 'vue-property-decorator';
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css'

import AnimalName from "../edit_mode/animal_name.vue"
import AnimalType from "../edit_mode/animal_type.vue"
import Countory from "../edit_mode/countory.vue"
import Hair from "../edit_mode/hair.vue"
import Weight from "../edit_mode/weight.vue"
import Height from "../edit_mode/height.vue"
import EditForm from "../edit_form.vue"

import utils from "../../../../lib/utils"
import moment from 'moment/moment'

Vue.use(ElementUI);

@Component({
  components:{ 
    "animal-type": AnimalType,
    "animal-name": AnimalName,
    "countory": Countory,
    "hair": Hair,
    "weight": Weight,
    "height": Height,
    "edit-form": EditForm
  }
})
export default class List extends Vue {
  @Prop({ required: true }) animalModel
  @Prop({ required: true }) info
  @Prop({ required: true }) editMode
  @Prop({ required: true }) fetchLoading
  @Prop({ required: true }) animalTypeList
  @Prop({ required: true }) countoryList
  @Prop({ required: true }) hairList

  private tableLoading = false
  private animals = []

  private animalTypeToLabel = {}
  private countoryToLabel = {}
  private hairToLabel = {}

  private editFormVisible = false
  private editRow = { idx:0, info: {} }

  created(){
    this.hairToLabel =  utils.createValueToLabelHash( this.hairList )
    this.animalTypeToLabel = utils.createIdToLabelHash( this.animalTypeList )
    this.countoryToLabel = utils.createIdToLabelHash( this.countoryList )
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

  private updateRow(updatedRecord){
    const idx = this.editRow.idx
    this.$set(this.animals[idx], "name", updatedRecord.name)
    this.$set(this.animals[idx], "animal_type_id", updatedRecord.animal_type_id)
    this.$set(this.animals[idx], "countory_id", updatedRecord.countory_id)
    this.$set(this.animals[idx], "weight", updatedRecord.weight)
    this.$set(this.animals[idx], "height", updatedRecord.height)
    this.$set(this.animals[idx], "hair", updatedRecord.hair)
    this.$set(this.animals[idx], "updated_at", updatedRecord.updated_at)
  }

  private onClickEditBtn(idx, row){
    this.$set(this.editRow, "idx", idx)
    this.$set(this.editRow, "info", row)
    this.editFormVisible = true
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
