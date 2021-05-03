<template>
  <div id="search-form">
    <el-tabs type="border-card" style="margin-bottom: 30px;">
      <el-tab-pane>
        <span slot="label"><i class="el-icon-search"></i> 検索フォーム</span>
        <el-row :gutter="20">

          <el-col :span="5"> <el-input placeholder="動物名" v-model="name_cont"></el-input> </el-col>

          <el-col :span="5"> 
            <el-select v-model="animal_type_id_eq" placeholder="種類">
              <el-option
                v-for="item in animalTypeList"
                :key="item.id"
                :label="item.label"
                :value="item.id">
              </el-option>
            </el-select>
          </el-col>

          <el-col :span="5"> 
            <el-select v-model="countory_id_eq" placeholder="原産国">
              <el-option
                v-for="item in countoryList"
                :key="item.id"
                :label="item.label"
                :value="item.id">
              </el-option>
            </el-select>
          </el-col>

          <el-col :span="5"> 
            <el-select v-model="hair_eq" placeholder="体毛">
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

  private name_cont = ""
  private animal_type_id_eq = ""
  private countory_id_eq = ""
  private hair_eq = ""

  private hairList = HAIR_LIST

  onSearch(){
    this.$emit('update:name_cont', this.name_cont)
    this.$emit('update:animal_type_id_eq', this.animal_type_id_eq)
    this.$emit('update:countory_id_eq', this.countory_id_eq)

    this.$emit('update:hair_eq', this.hair_eq)

    this.$emit('update:offset', 0)
    this.$emit("search")
  }

  onClear(){
    this.name_cont = ""
    this.$emit('update:name_cont', "")

    this.animal_type_id_eq = ""
    this.$emit('update:animal_type_id_eq', "")

    this.countory_id_eq = ""
    this.$emit('update:countory_id_eq', "")

    this.hair_eq = ""
    this.$emit('update:hair_eq', "")

    this.$emit('update:offset', 0)
    this.$emit("search")
  }
}
</script>

<style scoped>
</style>
