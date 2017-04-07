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
  },

  setFavorite(photo_id, cb) {
    axios.get(config.host + '/photos/favorite/' + photo_id ).then((res) => {
      cb(res.data)
    })
  },

  setUnFavorite(photo_id, cb) {
    axios.get(config.host + '/photos/unfavorite/' + photo_id ).then((res) => {
      cb(res.data)
    })
  }

}