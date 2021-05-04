<template>
  <div id="wrap-select"> 
    <el-select v-model="wrapSelectValue" @change="onChage" placeholder="Select" filterable ref="elSelect">
      <el-option
        v-for="item in selectList"
        :key="item.label"
        :label="item.label"
        :value="item[itemName]">
      </el-option>
    </el-select>
  </div>
</template>

<script lang="ts">
import { Component, Vue, Prop } from 'vue-property-decorator';
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';

Vue.use(ElementUI);

@Component
export default class WrapSelect extends Vue {
  @Prop() value
  @Prop() selectList
  @Prop() itemName

  private wrapSelectValue = ""

  created(){
    this.wrapSelectValue = this.value
  }

  onChage(val){
    this.$emit("change", val)
  }
}
</script>

<style>
</style>
