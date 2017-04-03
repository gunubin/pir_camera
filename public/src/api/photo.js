import config from '../config';
import axios from 'axios';

export default {
  getPhotos(params, cb) {
    axios.get(config.host + '/photos/', {params: params}).then((res) => {
      cb(res.data)
    })
  }
}