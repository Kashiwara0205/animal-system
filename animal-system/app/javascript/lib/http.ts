import axios from 'axios';

export default{
  get(url, params){
    return axios.get(url, { params:params });
  },

  getAll(requestList){
    return Promise.all( requestList.map(x => axios.get(x["url"], { params: x["params"] })) )
  }
}