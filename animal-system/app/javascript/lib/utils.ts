export default {
  createNameToJaNameHash(list){
    return list.reduce((acc, r)=>{
      acc[r["value"]] = r["ja_value"]
      return acc
    },{})
  }
}