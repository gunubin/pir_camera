import photoAPI from '../../api/photo'
import * as types from '../mutation-types'
import _ from 'underscore'

const state = {
  spinner: false,
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
  spinner: state => state.spinner,
  allPhotos: state => state.all,
  filter: state => state.filter,
  page: state => state.page
}

const actions = {
  getAllPhotos ({ commit }, filter) {
    commit(types.RECEIVE_SPINNER, {spinner: true})
    commit(types.RECEIVE_FILTER, {filter})
    photoAPI.getPhotos(filter, (photos) => {
      commit(types.RECEIVE_PHOTOS, { photos })
      commit(types.RECEIVE_SPINNER, {spinner: false})
    })
  },
  getDatePhotos ({ commit }, day) {
    commit(types.RECEIVE_SPINNER, {spinner: true})
    photoAPI.getPhotos({day: day}, (photos) => {
      commit(types.RECEIVE_DATE_PHOTOS, { photos })
      commit(types.RECEIVE_SPINNER, {spinner: false})
    })
  },
  getMorePhotos ({ commit }, filter) {
    commit(types.RECEIVE_SPINNER, {spinner: true})
    commit(types.RECEIVE_PAGE, {})

    let params = Object.assign({}, filter, {page: state.page})
    photoAPI.getPhotos(params, (photos) => {
      commit(types.RECEIVE_MORE_PHOTOS, { photos })
      commit(types.RECEIVE_SPINNER, {spinner: false})
    })
  },
  setFilter ({ commit }, filter) {
    commit(types.RECEIVE_FILTER, {filter})
  },
  setFavorite ({ commit }, photo ) {
    commit(types.RECEIVE_SPINNER, {spinner: true})
    if (photo.favorite) {
      photoAPI.setUnFavorite(photo.id, (res) => {
        commit(types.RECEIVE_FAVORITE, {photo})
        commit(types.RECEIVE_SPINNER, {spinner: false})
      })
    } else {
      photoAPI.setFavorite(photo.id, (res) => {
        commit(types.RECEIVE_FAVORITE, {photo})
        commit(types.RECEIVE_SPINNER, {spinner: false})
      })
    }
  },
  updatePhoto ({ commit }, payload) {
    commit(types.RECEIVE_SPINNER, {spinner: true})
    photoAPI.updatePhoto(payload.photo.id, payload.params, (res) => {
      commit(types.RECEIVE_UPDATE_PHOTO, {payload})
      commit(types.RECEIVE_SPINNER, {spinner: false})
    })
  },
}

const mutations = {
  [types.RECEIVE_SPINNER](state, { spinner }) {
    state.spinner = spinner
  },
  [types.RECEIVE_PHOTOS](state, { photos }) {
    state.page = 1
    state.all = photos
  },
  [types.RECEIVE_DATE_PHOTOS](state, { photos }) {
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
  [types.RECEIVE_UPDATE_PHOTO](state, {payload} ) {
    _.each(payload.params, (val, key) => {
      payload.photo[key] = payload.params[key]
    })
  },
}

export default {
  state,
  getters,
  actions,
  mutations
}