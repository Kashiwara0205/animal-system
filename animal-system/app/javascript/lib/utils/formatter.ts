import * as moment from 'moment/moment'

export const formatDateTime = (value)=>{
  return moment(value).format("YYYY-MM-DD HH:mm")
}