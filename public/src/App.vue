<template>
  <div id="app">
    <photoContainer></photoContainer>
  </div>
</template>

<script>
import PhotoContainer from './components/PhotoContainer'

export default {
  name: 'app',
  components: {
    PhotoContainer
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
