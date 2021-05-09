type Config = {
  title: string,
  message: string
}

export default {
  notifySuccess(self, conf: Config){
    self.$notify.success({
      title: conf["title"],
      message: conf["message"],
      position: 'top-left',
      duration: 2000
    });
  },

  notifyCancel(self){
    self.$notify.info({
      title: "キャンセル",
      message: "キャンセルしました",
      position: 'top-left',
      duration: 2000
    });
  },

  notifyError(self, title="エラー発生", message="予期せぬエラーが発生しました"){
    self.$notify.error({
      title: title,
      message: message,
      position: 'top-left'
    });
  }
}