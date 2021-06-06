<template>
  <div id="search-form">
    <el-tabs type="border-card" style="margin-bottom: 30px;">
      <el-tab-pane>
        <span slot="label"><i class="el-icon-search"></i> 検索フォーム</span>
        <el-row :gutter="20">

          <el-col :span="5"> <el-input placeholder="質問者" v-model="query.member_name_cont"></el-input> </el-col>

          <el-col :span="5"> <el-input placeholder="タイトル" v-model="query.title_cont"></el-input> </el-col>

          <el-col :span="5"> 
            <el-select v-model="query.phase_eq_any" filterable multiple placeholder="対応">
              <el-option
                v-for="item in phaseList"
                :key="item.label"
                :label="item.label"
                :value="item.value">
              </el-option>
            </el-select>
          </el-col>

        <el-col :span="5">
          <el-date-picker
            v-model="query.created_at_gteq"
            type="datetime"
            placeholder="質問日時(以降)">
          </el-date-picker>
        </el-col>
      </el-row>

      <br>

      <el-row :gutter="20">
        <el-col :span="5"> <el-input placeholder="質問内容" v-model="query.content_cont"></el-input> </el-col>
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
import { createQueryForm } from "../../../lib/utils/form_builder/question"
import 'element-ui/lib/theme-chalk/index.css';

Vue.use(ElementUI);

@Component
export default class SearchPanel extends Vue {
  @Prop({ required: true }) phaseList

  private query = createQueryForm()

  onSearch(){
    this.updateParentQuery()

    this.$emit('update:offset', 0)
    this.$emit("search")
  }

  onClear(){
    this.query = createQueryForm()
    this.updateParentQuery()

    this.$emit('update:offset', 0)
    this.$emit("search")
  }

  updateParentQuery(){
    this.$emit(`update:query`, this.query)
  }
}
</script>

<style scoped>
</style>
