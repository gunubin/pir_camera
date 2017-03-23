<template>
  <div class="face">
    <bounds
        :face="face"
        :bounds="face.bounds"
        :ratio="ratio"
    ></bounds>
  </div>
</template>

<script>
  import Bounds from './Bounds'

  export default {
    name: 'face',
    components: {
      Bounds
    },
    props: [
      'id',
      'face',
      'ratio',
    ]
  }
</script>

<style scoped>
  .face {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
  }
</style>
