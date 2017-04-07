import photoAPI from '../../api/photo'
import * as types from '../mutation-types'
import _ from 'underscore'

const state = {
  all: {},
  filter: {
    favorite: false,
    noface: false,
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
    commit(types.RECEIVE_FILTER, {filter})
    photoAPI.getPhotos(filter, (photos) => {
      commit(types.RECEIVE_PHOTOS, { photos })
    })
  },
  getMorePhotos ({ commit }, filter) {
    commit(types.RECEIVE_PAGE, {})

    let params = Object.assign({}, filter, {page: state.page})
    photoAPI.getPhotos(params, (photos) => {
      commit(types.RECEIVE_MORE_PHOTOS, { photos })
    })
  },
  setFilter ({ commit }, filter) {
    commit(types.RECEIVE_FILTER, {filter})
  },
  setFavorite ({ commit }, photo ) {
    if (photo.favorite) {
      photoAPI.setUnFavorite(photo.id, (res) => {
        commit(types.RECEIVE_FAVORITE, {photo})
      })
    } else {
      photoAPI.setFavorite(photo.id, (res) => {
        commit(types.RECEIVE_FAVORITE, {photo})
      })
    }
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
  [types.RECEIVE_PAGE](state, {}) {
    state.page++
  },
  [types.RECEIVE_FILTER](state, { filter }) {
    _.each(filter,(val, key) => {
      state.filter[key] = val
    })
  },
  [types.RECEIVE_FAVORITE](state, {photo} ) {
    photo.favorite = !photo.favorite
  },
}

export default {
  state,
  getters,
  actions,
  mutations
}