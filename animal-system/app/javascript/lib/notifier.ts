export default {
  notifyError(self, title="エラー発生", message="予期せぬエラーが発生しました"){
    self.$notify.error({
      title: title,
      message: message,
      position: 'top-left'
    });
  }
}