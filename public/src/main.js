// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.

import Vue from 'vue'

import axios from 'axios'
import VueAxios from 'vue-axios'
import VueMaterial from 'vue-material'
import vueMoment from 'vue-moment'
import moment from 'moment'
import locale_ja from 'moment/locale/ja'



moment.locale('ja', locale_ja)
Vue.use(vueMoment, {
  moment
})

Vue.use(VueAxios, axios)
Vue.use(VueMaterial)

import App from './App'
import store from './store/index'

Vue.config.productionTip = false

new Vue({
  el: '#app',
  store,
  template: '<App/>',
  components: { App }
})
