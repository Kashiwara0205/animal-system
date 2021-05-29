<template>
  <div>
    <el-button type="success" size="mini" @click="onDownload"class="download-btn">
      CSVダウンロード <i class="el-icon-download"></i>
    </el-button>
  </div>
</template>

<script lang="ts">
import { Component, Vue, Prop } from 'vue-property-decorator';
import http from '../../../lib/http'
import notifier from '../../../lib/notifier' 
import utils from "../../../lib/utils/common"
import moment from 'moment/moment'

@Component
export default class DownloadBtn extends Vue {
  @Prop({ required: true }) query
  @Prop({ required: true }) url
  @Prop({ required: true }) hairList
  @Prop({ required: true }) animalTypeList
  @Prop({ required: true }) countoryList

  private hairToLabel = {}
  private animalTypeToLabel = {}
  private countoryToLabel = {}

  created(){
    this.hairToLabel =  utils.createValueToLabelHash( this.hairList )
    this.animalTypeToLabel = utils.createIdToLabelHash( this.animalTypeList )
    this.countoryToLabel = utils.createIdToLabelHash( this.countoryList )
  }

  async onDownload(){
    const info = await this.fetchInfo()
    const now = moment().format("YYYY-MM-DD")

    const header = this.createCsvHeader(["動物名", "種類", "原産国", "体重", "身長", "体毛", "登録日時", "更新日時"])    
    const data = this.createCsvData(info)
    const csvData = `${header}${data}`

    var bom = new Uint8Array([0xEF, 0xBB, 0xBF]);
    var downloadLink = document.createElement("a");
    downloadLink.download = `${now} 動物一覧.csv`
    downloadLink.href = URL.createObjectURL(new Blob([bom, csvData], { type: "text/csv" }));
    downloadLink.dataset.downloadurl = ["text/csv", downloadLink.download, downloadLink.href].join(":");
    downloadLink.click();

    notifier.notifySuccess(this, {title: "ダウンロード完了", message: "CSVをダウンロードしました"})
  }

  createCsvHeader(columns){
    return columns.join(",") + "\n"
  }

  createCsvData(info){
    return info.reduce((acc, r) =>{

      acc += r["name"] + "," 
      acc += this.animalTypeToLabel[ r["animal_type_id"] ] + "," 
      acc += this.countoryToLabel[ r["countory_id"] ] + "," 
      acc += r["weight"] + "kg," 
      acc += r["height"] + "cm," 
      acc += this.hairToLabel[ r["hair"] ] + "," 
      acc += this.formatDatetime( r["created_at"] ) + "," 
      acc += this.formatDatetime( r["updated_at"] ) + "\n" 

      return acc
    }, "")
  }

  private formatDatetime(datetime){
    return moment(datetime).format("YYYY-MM-DD HH:mm")
  }

  async fetchInfo(){
    try{
      const params = { query: this.query }
      const res = await http.get(this.url, params);
      return res["data"]["info"]
    }catch(e){
      notifier.notifyError(this)
    }
  }
}
</script>

<style scoped>
  .download-btn{
    margin-bottom: 10px;
  }
</style>
