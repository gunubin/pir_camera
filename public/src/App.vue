<template>
  <div id="app">
    <headerComponent :config="config"></headerComponent>
    <photoContainer :config="config"></photoContainer>
  </div>
</template>

<script>
  import Config from './Config'
  import HeaderComponent from './components/HeaderComponent'
  import PhotoContainer from './components/PhotoContainer'

  export default {
    name: 'app',
    components: {
      HeaderComponent,
      PhotoContainer
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
