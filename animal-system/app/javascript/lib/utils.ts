export default {
  createValueToLabelHash(list){
    return list.reduce((acc, r)=>{
      acc[r["value"]] = r["label"]
      return acc
    },{})
  }
}