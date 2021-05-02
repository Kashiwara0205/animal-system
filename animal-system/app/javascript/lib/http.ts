import axios from 'axios';
import qs from "qs";

function createConfig(params){
  return {
    method: 'get',
    params: params,
    paramsSerializer(params) {
      return qs.stringify(params)
    },
    responseType: 'json'
  }
}

export default{
  get(url, params){
    const config = createConfig(params) as any
    return axios.get(url, config);
  },

  getAll(requestList){
    return Promise.all( requestList.map(x => axios.get(x["url"],  createConfig(x["params"]) as any)) )
  }
}