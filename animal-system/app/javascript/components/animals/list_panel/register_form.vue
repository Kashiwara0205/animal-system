
<template>
  <span>
    <el-dialog title="動物追加フォーム" :before-close="onClose" :visible.sync="registerFormVisible">
      <el-form :model="form" :rules="rules" ref="form" >
      
        <el-form-item label="動物名" prop="name">
          <el-input v-model="form.name" placeholder="動物名を入力してください"></el-input>
        </el-form-item>

        <el-form-item label="種類" prop="animalTypeId">
          <br>
          <el-select v-model="form.animalTypeId" placeholder="種類を入力してください" filterable style="width: 100%">
            <el-option
              v-for="item in animalTypeList"
                :key="item.label"
                :label="item.label"
                :value="item.id">
            </el-option>
          </el-select>
        </el-form-item>

        <el-form-item label="原産国" prop="countoryId">
          <br>
          <el-select v-model="form.countoryId" placeholder="原産国を入力してください" filterable style="width: 100%">
            <el-option
              v-for="item in countoryList"
                :key="item.label"
                :label="item.label"
                :value="item.id">
            </el-option>
          </el-select>
        </el-form-item>
      
        <el-form-item label="体重(kg)" prop="weight">
          <el-input v-model="form.weight" placeholder="体重を入力してください"></el-input>
        </el-form-item>

        <el-form-item label="身長(cm)" prop="height">
          <el-input v-model="form.height" placeholder="身長を入力してください"></el-input>
        </el-form-item>

        <el-form-item label="体毛" prop="hair">
          <br>
          <el-select v-model="form.hair" placeholder="体毛を入力してください" filterable style="width: 100%">
            <el-option
              v-for="item in hairList"
                :key="item.label"
                :label="item.label"
                :value="item.value">
            </el-option>
          </el-select>
        </el-form-item>
      </el-form>

      <div v-if="errors.length > 0" class="error-message">
        <b> エラーが発生しました </b>
        <li v-for="message in errors" :key="message">
          {{ message }}
        </li>
      </div>

      <span slot="footer" class="dialog-footer">
        <el-button type="primary" @click="onClickConfirm()">登録</el-button>
        <el-button @click="onClose()">キャンセル</el-button>
      </span>
    </el-dialog>

  </span>
</template>

<script lang="ts">
import { Component, Vue, Prop } from 'vue-property-decorator';
import http from '../../../lib/http'
import notifier from '../../../lib/notifier' 

const EMPTY_FORM = {
  name: "",
  animalTypeId: "",
  countoryId: "",
  weight: "",
  height: "",
  hair: ""
}

@Component
export default class RegisterBtn extends Vue {
  @Prop({ required: true }) registerFormVisible
  @Prop({ required: true }) url
  @Prop({ required: true }) animalTypeList
  @Prop({ required: true }) countoryList
  @Prop({ required: true }) hairList

  private form = EMPTY_FORM
  private errors = []

  private rules = {
    name: [
      { required: true, message: '動物名は必須入力です', trigger: 'blur' },
    ],

    animalTypeId: [
      { required: true, message: '種類は必須入力です', trigger: 'blur' },
    ],

    countoryId: [
      { required: true, message: '原産国は必須入力です', trigger: 'blur' },
    ],

    weight: [
      { required: true, message: '体重は必須入力です', trigger: 'blur' },
    ],

    height: [
      { required: true, message: '身長は必須入力です', trigger: 'blur' },
    ],

    hair: [
      { required: true, message: '体毛は必須入力です', trigger: 'blur' },
    ],
  }

  private resetForm(){
    this.$refs["form"].resetFields();
  }

  private createParamter(){
    return {
      create_info:{ 
        name: this.form.name,
        animal_type_id: this.form.animalTypeId,
        countory_id: this.form.countoryId,
        weight: this.form.weight,
        height: this.form.height,
        hair: this.form.hair
      }
    }
  }

  private async submit(){
    try{
      const params = this.createParamter()
      const res = await http.post(this.url, params)

      notifier.notifySuccess(this, {title: "登録成功", message: "登録を完了しました"})

      this.$emit('update:registerFormVisible', false)
      this.$emit("complete")
    }catch(e){
      console.log(e)
      notifier.notifyError(this)
    }
  }

  private onClickConfirm(){
    this.$refs["form"].validate((valid) => {
      if (valid) {
        this.submit()
      } else {
        this.errors = ["入力内容に誤りがあります"]
        return false;
      }
    });
  }

  private onClose(){
    this.$emit('update:registerFormVisible', false)
    this.resetForm()
  }
}
</script>

<style>

.error-message{
  border-radius: 10px;
  margin-top: 40px;
  padding: 10px;
  color: #FF3C3C;
  background-color: #FFB4C0;
}

</style>