<template>
  <div>
    <content-dialog 
      @update:dialogVisible='contentDialogVisible = $event'
      :dialog-visible="contentDialogVisible"
      :title="title"
      :content="content" 
      :memberName="memberName">
    </content-dialog>

    <similar-question
      @update:dialogVisible='similarQuestionDialogVisible = $event'
      :dialog-visible="similarQuestionDialogVisible"
      :title="title"
      :id="questionId" >
    </similar-question>

    <el-table
      :data="questions"
      @hook:mounted="complete"
      height="500"
      v-loading="tableLoading"
      element-loading-text="Loading..."
      border
      style="width: 100%;">

      <el-table-column label="質問者" prop="member_name"></el-table-column>
      <el-table-column label="タイトル" prop="title" :formatter="formatTitleEl"></el-table-column>
      <el-table-column label="質問内容" prop="content">
        <template v-slot="scope">
          <el-link type="primary" @click="onClickContentLink(scope.row)">
            {{formatContent(scope.row.content)}}
          </el-link>
        </template>
      </el-table-column>
      <el-table-column label="対応" prop="phase" :formatter="formatPhaseEl"></el-table-column>
      <el-table-column label="質問日時" prop="created_at" :formatter="formatDatetimeEl"></el-table-column>
      <el-table-column label="最終対応日時" prop="updated_at" :formatter="formatDatetimeEl" ></el-table-column>
      <el-table-column label="操作" align="center" width="150px"> 
        <template v-slot="scope">
           <el-button size="small" @click="onClickSimilarQuestion(scope.row)">類似質問</el-button>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script lang="ts">
import { Component, Vue, Prop, Watch } from 'vue-property-decorator';
import { formatDateTime } from "../../../lib/utils/formatter"
import utils from "../../../lib/utils/common"
import ContentDialog from "./dialog/content.vue"
import SimilarQuestion from "./similar_question.vue"

@Component({
  components:{ 
    ContentDialog,
    SimilarQuestion
  }
})
export default class List extends Vue {
  @Prop({ required: true }) info
  @Prop({ required: true }) phaseList
  @Prop({ required: true }) fetchLoading

  private paginationOffset = 0
  private questionId = 0
  private questions = []
  private tableLoading = false

  private contentDialogVisible = false
  private similarQuestionDialogVisible = false

  private phaseToLabel = {}

  private content = ""
  private memberName = ""
  private title = ""

  created(){
    this.phaseToLabel =  utils.createValueToLabelHash( this.phaseList )
  }

  private fetchInfo(){ 
    this.$emit('update:offset', this.paginationOffset)
    this.$emit("fetchInfo") 
  }

  // fetchのloading処理が終わった後にlazyLoadを作動
  @Watch("fetchLoading")
  private complete(val){
    if(!val){ this.lazyLoad(JSON.parse(JSON.stringify(this.info))) }
  }

  private lazyLoad(copyInfo){
    const self = this;
    this.questions = [];
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
              self.questions.push(item)
            }
            load.next()
          })
        }
    }()

    load.next()
  }

  private formatDatetimeEl(row, col, value, index){ return formatDateTime(value) }

  private formatPhaseEl(row, col, value, index){
    if (value in this.phaseToLabel) { return this.phaseToLabel[value] }
    return value
  }

  private formatContent(value){
    if(value.length > 20){ 
      return `${value.substr( 0, 20 )}...`
    }
    return value
  }

  private formatTitleEl(row, col, value, index){
    if(value.length > 20){ 
      return `${value.substr( 0, 20 )}...`
    }
    return value
  }

  private onClickContentLink(row){
    this.content = row.content
    this.memberName = row.member_name
    this.title = row.title
    this.contentDialogVisible = true
  }

  private onClickSimilarQuestion(row){
    this.similarQuestionDialogVisible = true
    this.questionId = row.id
    this.title = row.title
  }
}
</script>

<style scoped>
.panel{
  overflow: scroll; 
  height: 500px;
}

</style>