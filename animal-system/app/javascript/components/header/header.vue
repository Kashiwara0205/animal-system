<template>
  <div>
    <el-menu
      mode="horizontal"
      @select="handleSelect"
      background-color="#545c64"
      text-color="#fff"
      active-text-color="#ffd04b">
      <el-menu-item index="/" style="padding-right: 30px">
       <i class="el-icon-s-tools"></i> <b>動物事業管理システム</b>
      </el-menu-item>
      <el-submenu index="animals"> 
        <template slot="title">動物関連</template>
        <el-menu-item index="/animals">
          <i class="el-icon-document"></i> 動物情報 一覧
        </el-menu-item>
      </el-submenu>
      <el-submenu index="4">
        <template slot="title">メンバー関連</template>
        <el-menu-item index="/questions">
          <i class="el-icon-document"></i> 質問情報 一覧
        </el-menu-item>
      </el-submenu>
      <!--
      <el-submenu index="3">
        <template slot="title">イベント関連</template>
        <el-menu-item index="/events">
          <i class="el-icon-document"></i> イベント情報 一覧
        </el-menu-item>
      </el-submenu>
      </el-submenu>
      <el-submenu index="5">
        <template slot="title">その他</template>
        <el-menu-item index="/staffs">
          <i class="el-icon-document"></i> スタッフ情報 一覧
          </el-menu-item>
        <el-menu-item index="/contacts">
          <i class="el-icon-document"></i> 問い合わせ情報 一覧
          </el-menu-item>
      </el-submenu>
      -->
    </el-menu>
  </div>
</template>

<script lang="ts">
export default {
  methods:{
    handleSelect: function (url) { 
      window.location.href = url
    }
  }
}
</script>

<style scoped>

</style>

