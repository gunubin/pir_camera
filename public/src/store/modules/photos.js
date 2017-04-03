import photo from '../../api/photo'
import * as types from '../mutation-types'

const state = {
  all: []
}

const getters = {
  allPhotos: state => state.all
}

const actions = {
  getAllPhotos ({ commit }, filter) {
    photo.getPhotos(filter, photos => {
      commit(types.RECEIVE_PHOTOS, { photos })
    })
  },
  getBlurredPhotos ({ commit }) {
    photo.getPhotos({filter: 'blurred'}, photos => {
      commit(types.RECEIVE_PHOTOS, { photos })
    })
  },
  getHeadwearPhotos ({ commit }) {
    photo.getPhotos({filter: 'headwear'}, photos => {
      commit(types.RECEIVE_PHOTOS, { photos })
    })
  },
  getJoyPhotos ({ commit }) {
    photo.getPhotos({filter: 'joy'}, photos => {
      commit(types.RECEIVE_PHOTOS, { photos })
    })
  },
  getSorrowPhotos ({ commit }) {
    photo.getPhotos({filter: 'sorrow'}, photos => {
      commit(types.RECEIVE_PHOTOS, { photos })
    })
  },
  getSurprisePhotos ({ commit }) {
    photo.getPhotos({filter: 'surprise'}, photos => {
      commit(types.RECEIVE_PHOTOS, { photos })
    })
  },
  getUnderExposedPhotos ({ commit }) {
    photo.getPhotos({filter: 'under_exposed'}, photos => {
      commit(types.RECEIVE_PHOTOS, { photos })
    })
  }
}

const mutations = {
  [types.RECEIVE_PHOTOS](state, { photos }) {
    state.all = photos
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}