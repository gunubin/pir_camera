<template>
  <div id="app">
    <headerComponent :config="config" v-on:onClickCalender="onClickCalender" ></headerComponent>
    <dailyContainer :config="config"></dailyContainer>

    <date-picker :date="startTime" :option="option" :limit="limit" ref="cal" v-on:checkday="onCheckDay" v-on:calCancel="onCalcancel"></date-picker>
  </div>
</template>

<script>
  import Config from './Config'
  import HeaderComponent from './components/HeaderComponent'
  import DailyContainer from './components/DailyContainer'
  import datepicker from './components/vue-datepicker-es6.vue';

  export default {
    name: 'app',
    components: {
      HeaderComponent,
      DailyContainer,
      'date-picker': datepicker,
    },
    methods: {
      onClickCalender: function () {
        this.$refs.cal.showCheck();
      },
      onCheckDay: function(t) {
        this.$store.dispatch('getDatePhotos', t.date.time)
      },
      onCalcancel: function(t) {
      }
    },
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
          week: ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'],
          month: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
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
        timeoption: {
          type: 'min',
          week: ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'],
          month: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
          format: 'YYYY-MM-DD HH:mm'
        },
        multiOption: {
          type: 'multi-day',
          week: ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'],
          month: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
          format: "YYYY-MM-DD HH:mm"
        },
        limit: [
          {
            type: 'weekday',
            available: [1, 2, 3, 4, 5]
          },
//          {
//            type: 'fromto',
//            from: '2016-02-01',
//            to: '2016-02-20'
//          }
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
