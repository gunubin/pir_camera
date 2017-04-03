import photo from '../../api/photo'
import * as types from '../mutation-types'

const state = {
  all: {},
  filter: {
    blurred: false,
    headwear: false,
    joy: false,
    sorrow: false,
    surprise: false,
    underExposed: false,
  },
  page: 1
}

const getters = {
  allPhotos: state => state.all,
  filter: state => state.filter,
  page: state => state.page
}

const actions = {
  getAllPhotos ({ commit }, filter) {
    photo.getPhotos(filter, (photos) => {
      commit(types.RECEIVE_PHOTOS, { photos })
    })
  },
  getMorePhotos ({ commit }, filter) {
    commit(types.RECEIVE_PAGE, {})

    let params = Object.assign({}, filter, {page: state.page})
    photo.getPhotos(params, (photos) => {
      commit(types.RECEIVE_MORE_PHOTOS, { photos })
    })
  },
  setFilter ({ commit }, filter) {
    commit(types.RECEIVE_FILTER, {filter})
  },
}

const mutations = {
  [types.RECEIVE_PHOTOS](state, { photos }) {
    state.page = 1
    state.all = photos
  },
  [types.RECEIVE_MORE_PHOTOS](state, { photos }) {
    state.all = Object.assign({}, state.all, photos)
  },
  [types.RECEIVE_PAGE](state, { }) {
    state.page++
  },
  [types.RECEIVE_FILTER](state, { filter }) {
    state.filter = filter
  },
}

export default {
  state,
  getters,
  actions,
  mutations
}