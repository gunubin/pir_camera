import config from '../config'
import axios from 'axios'
import moment from 'moment'
import _ from 'underscore'

function _getDate(data) {
  let daily = {}

  data.forEach(item => {
    let d = moment(item.created_at).format('YYYY/MM/DD(ddd)')

    if (_.isUndefined(daily[d])) {
      daily[d] = [];
    }
    daily[d].push(item)
  })
  return daily
}

export default {

  getPhotos(params, cb) {
    axios.get(config.host + '/photos/', {params: params}).then((res) => {
      cb(_getDate(res.data))
    })
  }
}