<template>
  <div id="search-form">
    <el-tabs type="border-card" style="margin-bottom: 30px;">
      <el-tab-pane>
        <span slot="label"><i class="el-icon-search"></i> 検索フォーム</span>
        <el-row :gutter="20">
          <el-col :span="6"> <el-input placeholder="動物名" v-model="name_cont" @input="$emit('update:name_cont', name_cont)"></el-input> </el-col>
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
import 'element-ui/lib/theme-chalk/index.css';

Vue.use(ElementUI);

@Component
export default class SearchPanel extends Vue {
  private name_cont = ""

  onSearch(){
    this.$emit('update:offset', 0)
    this.$emit("search")
  }

  onClear(){
    this.name_cont = ""
    this.$emit('update:name_cont', "")

    this.$emit('update:offset', 0)
    this.$emit("search")
  }
}
</script>

<style scoped>
</style>
