<template>
  <div id="wrap-select"> 
    <!-- クリックされていなかったらoptionなしで描画 -->
    <div v-if="!clicked">
      <el-select @focus="onClick" :value="label">
      </el-select>
    </div>
    <!-- クリックされたらoptionありで描画。
         描画コスト削減のためにクリックされるまでoptionは描画しない-->
    <div v-show="clicked">
      <el-select v-model="rowValue" :blur="true" placeholder="Select" ref="elSelect">
        <div v-if="clicked">
          <el-option
            v-for="item in selectList"
            :key="item.value"
            :label="item.label"
            :value="item.value">
          </el-option>
        </div>
      </el-select>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Vue, Prop } from 'vue-property-decorator';
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';

Vue.use(ElementUI);

@Component
export default class WrapSelect extends Vue {
  @Prop() toLabelHash
  @Prop() rowValue
  @Prop() selectList

  private clicked = false

  get label(){
    if (this.rowValue in this.toLabelHash) { return this.toLabelHash[this.rowValue] }
    return this.rowValue
  }

  private onClick(){
    this.clicked = true
    const elem = this.$refs.elSelect as any
    // クリックされたら、option付きで描画する方のセレクトボックスを展開する
    const input = elem.$el.querySelector('.el-input__inner');
    input.click()
  }
  
}
</script>

<style>
</style>
