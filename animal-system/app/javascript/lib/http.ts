import axios from 'axios';
import qs from "qs";

function createConfig(params){
  return {
    method: 'get',
    params: params,
    paramsSerializer(params) {
      return qs.stringify(params,{
        arrayFormat: "brackets",
        encode: false
      })
    },
    responseType: 'json'
  }
}

export default{
  get(url, params){
    const config = createConfig(params) as any
    return axios.get(url, config);
  },

  put(url, params){
    return axios.put(url, params);
  },

  getAll(requestList){
    return Promise.all( requestList.map(x => axios.get(x["url"],  createConfig(x["params"]) as any)) )
  }
}