<template>
  <div id="app">

    <spinner v-if="spinner"></spinner>

    <headerComponent :config="config" v-on:onClickCalender="onClickCalender" v-on:clickMenuBtn="onClickMenuBtn"></headerComponent>

    <side ref="side"></side>

    <dailyContainer :config="config"></dailyContainer>

    <date-picker :date="startTime" :option="option" :limit="limit" ref="cal" v-on:checkday="onCheckDay" v-on:calCancel="onCalcancel"></date-picker>
  </div>
</template>

<script>
  import {mapGetters} from 'vuex'
  import Config from './Config'
  import HeaderComponent from './components/HeaderComponent'
  import DailyContainer from './components/DailyContainer'
  import Side from './components/Side'
  import Spinner from './components/Spinner'
  import datepicker from './components/vue-datepicker-es6.vue';

  export default {
    name: 'app',
    components: {
      HeaderComponent,
      Side,
      Spinner,
      DailyContainer,
      'date-picker': datepicker,
    },
    methods: {
      onClickMenuBtn: function () {
        this.$refs.side.toggleLeftSidenav()
      },
      onClickCalender: function () {
        this.$refs.cal.showCheck();
      },
      onCheckDay: function(t) {
        this.$store.dispatch('getDatePhotos', t.date.time)
      },
      onCalcancel: function(t) {
      }
    },
    computed: mapGetters({
      spinner: 'spinner',
    }),
    data () {
      return {
        config: Config,
        startTime: {
          time: ''
        },
        endtime: {
          time: ''
        },
        option: {
          type: 'day',
          week: ['月', '火', '水', '木', '金', '土', '日'],
          month: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'],
          format: 'YYYY-MM-DD',
          placeholder: 'when?',
          inputStyle: {
            'display': 'inline-block',
            'padding': '6px',
            'line-height': '22px',
            'font-size': '16px',
            'border': '2px solid #fff',
            'box-shadow': '0 1px 3px 0 rgba(0, 0, 0, 0.2)',
            'border-radius': '2px',
            'color': '#5F5F5F'
          },
          color: {
            header: '#ccc',
            headerText: '#f00'
          },
          buttons: {
            ok: 'Ok',
            cancel: 'Cancel'
          },
          overlayOpacity: 0.5, // 0.5 as default
          dismissible: true // as true as default
        },
        limit: [
          {
            type: 'weekday',
            available: [0, 1, 2, 3, 4, 5, 6]
          },
        ]
      }
    },
  }
</script>

<style>
  #app {
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    color: #2c3e50;
  }
</style>
