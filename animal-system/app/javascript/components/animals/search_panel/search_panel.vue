<template>
  <div id="search-form">
    <el-tabs type="border-card" style="margin-bottom: 30px;">
      <el-tab-pane>
        <span slot="label"><i class="el-icon-search"></i> 検索フォーム</span>
        <el-row :gutter="20">

          <el-col :span="5"> <el-input placeholder="動物名" v-model="query.name_cont"></el-input> </el-col>

          <el-col :span="5"> 
            <el-select v-model="query.animal_type_id_eq_any" filterable multiple placeholder="種類">
              <el-option
                v-for="item in animalTypeList"
                :key="item.id"
                :label="item.label"
                :value="item.id">
              </el-option>
            </el-select>
          </el-col>

          <el-col :span="5"> 
            <el-select v-model="query.countory_id_eq_any" filterable multiple placeholder="原産国">
              <el-option
                v-for="item in countoryList"
                :key="item.id"
                :label="item.label"
                :value="item.id">
              </el-option>
            </el-select>
          </el-col>

          <el-col :span="5"> 
            <el-select v-model="query.hair_eq_any" filterable multiple placeholder="体毛">
              <el-option
                v-for="item in hairList"
                :key="item.label"
                :label="item.label"
                :value="item.value">
              </el-option>
            </el-select>
          </el-col>
      </el-row>

      <br>

      <el-row :gutter="20">
        <el-col :span="5"> <el-input placeholder="体重(以上)" v-model="query.weight_gteq"></el-input> </el-col>
        <el-col :span="5"> <el-input placeholder="体重(以下)" v-model="query.weight_lteq"></el-input> </el-col>
        <el-col :span="5"> <el-input placeholder="身長(以上)" v-model="query.height_gteq"></el-input> </el-col>
        <el-col :span="5"> <el-input placeholder="身長(以下)" v-model="query.height_lteq"></el-input> </el-col>
      </el-row>

      <br>

      <el-row :gutter="20">
        <el-col :span="5">
          <el-date-picker
            v-model="query.created_at_gteq"
            type="datetime"
            placeholder="登録日時(以降)">
          </el-date-picker>
        </el-col>

        <el-col :span="5"> 
          <el-date-picker
            v-model="query.updated_at_gteq"
            type="datetime"
            placeholder="更新日時(以降)">
          </el-date-picker>
         </el-col>  
      </el-row>
      
      <br>

      <el-button type="primary" @click="onSearch"> 検索 </el-button>
      <el-button @click="onClear"> クリア </el-button>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script lang="ts">
import { Component, Vue, Prop, Watch } from 'vue-property-decorator';
import ElementUI from 'element-ui';
import { HAIR_LIST } from "../../../const"
import 'element-ui/lib/theme-chalk/index.css';

Vue.use(ElementUI);

@Component
export default class SearchPanel extends Vue {
  @Prop({ required: true }) animalTypeList
  @Prop({ required: true }) countoryList

  private query = this.createNewQuery()
  private hairList = HAIR_LIST

  createNewQuery(){
    return {
      name_cont: "",
      animal_type_id_eq_any: [],
      countory_id_eq_any: [],
      hair_eq_any: [],
      weight_gteq: "",
      weight_lteq: "",
      height_gteq: "",
      height_lteq: "",
      created_at_gteq: "",
      updated_at_gteq: ""
    }
  }

  onSearch(){
    this.updateParentQuery()

    this.$emit('update:offset', 0)
    this.$emit("search")
  }

  onClear(){
    this.query = this.createNewQuery()
    this.updateParentQuery()

    this.$emit('update:offset', 0)
    this.$emit("search")
  }

  updateParentQuery(){
    Object.keys(this.query).forEach(key => this.$emit(`update:${key}`, this.query[key]))
  }
}
</script>

<style scoped>
</style>
