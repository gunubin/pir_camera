<template>
  <div id="app">
    <headerComponent :config="config"></headerComponent>
    <dailyContainer :config="config"></dailyContainer>
  </div>
</template>

<script>
  import Config from './Config'
  import HeaderComponent from './components/HeaderComponent'
  import DailyContainer from './components/DailyContainer'

  export default {
    name: 'app',
    components: {
      HeaderComponent,
      DailyContainer
    },
    data () {
      return {
        config: Config
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
