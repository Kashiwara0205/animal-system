<template>
  <div id="infomation-panel" >
    <h3 style="padding-top:10px;">
      <i class="el-icon-news"></i> 更新履歴
    </h3>
    <el-tabs :tab-position="tabPosition" style="height: 80vh;" type="border-card">
      <el-tab-pane label="2021-10" class="panel" >
        <b> 10月09日 </b>
        <li> 調査の結果以下の対応が必要だと判明</li>
        <br> Vue3にバージョンアップさせるにはelement-uiからelement-plusに対応させる必要 
        <br> それにプラスしてvue-property-decoratorをすべて剥がさないとならない
      </el-tab-pane>
      <el-tab-pane label="2021-09" class="panel" >
        <b> 09月26日 </b>
        <li> Vue3にバージョンアップさせるために、slot-scopeと.syncを削除 </li>
        <br> これらの対応以外に、ライブラリであるelementをelement plusに変更する必要あり
        <br> しかし、現時点でelement plusの公式サイトに404が出ており情報が得られない
        <br> 時間をあけてから再度調査
      </el-tab-pane>
      <el-tab-pane label="2021-08" class="panel" >
        <b> 08月07日 </b>
        <li> ActiveRecordConverterを実装 </li>
        <br> map{|m| m.attributes}の動作を高速に処理することが出来る
        <br> Gem化予定
        <br>
        <br>
        <b> 08月06日 </b>
        <li> 大量のCSVデータのダウンロードを高速にするために調査 </li>
        <br> 改善前：5万レコード9秒かかる
        <br> Railsがデフォルトで使っているJSONレンダリングは遅い
        <br> 5万レコードのCSVダウンロード処理に関してJSON.generateに変更すると4秒ほど処理速度が縮まり5秒になった
        <br> ※ただし、JSON.generateを使用するにはmap{|m| m.attributes}で配列に変換しておく必要あり
        <br> 追記
        <br> pluckを使った処理に変更すると3秒に縮まった
        <br> pluckはフィールド名を引数にとるのでselectメソッドのフィールド名を自動で使いまわせる仕組みがほしい
      </el-tab-pane>
      <el-tab-pane label="2021-07" class="panel" >
        <b> 07月19日 </b>
        <li> プロトタイプのレコメンドシステムを追加</li>
      </el-tab-pane>
      <el-tab-pane label="2021-06" class="panel" >
        <b> 06月20日 </b>
        <li> 更新履歴の高さを350pxから80vhに変更</li>
        <li> 類似質問の抽出機能を入れるためにpytonのマイクロサービス追加</li>
        <br>
        <b> 06月06日 </b>
        <li> 質問情報一覧を追加</li>
        レコメンデーション機能を応用して以下の2つの機能を実装予定<br>
        類似質問の抽出処理(内容ベース)<br>
        予想される質問の抽出処理(フィルターベース)<br>

      </el-tab-pane>
      <el-tab-pane label="2021-05" class="panel" >
        <b> 05月29日 </b>
        <li> [動物情報 一覧] ローカルナビケージョンを追加して、そちらに権限情報を移動 </li><br>
        <li> [動物情報 一覧] 親子間における検索クエリの共有手法を変更 <br>
        別ファイルに構造のみ切り出し。JSONを使ったDeepCopyも考えたが、クリア時の動作が複雑になるのと   <br>
        オブジェクトの中のオブジェクトがコピーできない問題があるのでやめた。<br>
        </li>
         <br>
        - DeepCopyを使った時のクリア時の動作<br>
        [childQueryFormを、hashKeyごとにループさせてクリアする。この時に初期値が空文字でない要素あれば別途対応が必要]<br>
        <br>
        - ファイル切り出しの場合の動作<br>
        [childQueryFormに代入するだけ。親子間の参照渡し関連の不具合も発生しない]   <br>
        <br>

        <b> 05月22日 </b>
        <li>登録フォームを追加 <br>
        </li>

        <li>編集フォームを追加 <br>
             el-formのフロントバリデーションは、結構便利だった。普段の業務でも使えると思う。 <br>
        </li>
        <br>
        <li>動物名、体重、身長にバリデーションを追加 <br>
            el-message-boxのバリデーションは使いにくかった。<br>
            編集を押した後に必ずモーダルが閉じてしまうので使い勝手が悪い。<br>
            サーバー側のエラーを表示する時にモーダルが閉じるので、もう一度開かなければならない<br>
            エラーになるケースが、そんなに発生しないなら使っても大丈夫かも？<br>
            拡張性は低い。ボタン3にするとかは難しそう。<br>
        </li>
        <br>
        <b> 05月09日 </b>
        <li>動物一覧検索機能を追加</li>
        <li>動物一覧に編集モードを追加</li>
        <br>
        <b> 05月01日 </b>
        <li>ヘッダー追加</li>
        <li>更新履歴表示機能を追加</li>
      </el-tab-pane>
      <el-tab-pane label="2021-04" class="panel">
        <b> 04月23日 </b>
        <li>実験システム立ち上げ</li>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script lang="ts">
export default {
  data(){
    return {
      tabPosition: "left"
    }
  }
}
</script>

<style scoped>
  .panel{
    overflow: scroll; 
    height: 80vh;
  }
</style>
