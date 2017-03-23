<template>
  <div class="photo">
    <img ref="obj" :src="url" alt="">

    <face v-for="f in faces"
      :key="f.id"
      :face="f"
      :ratio="ratio"
    ></face>

  </div>
</template>

<script>
  import Face from './Face'

  export default {
    name: 'photo',
    props: [
      'path',
      'filename',
      'faces',
    ],
    components: {
      Face
    },
    data () {
      return {
        ratio: '',
      }
    },
    computed: {
      url: function() {
        return 'http://mbp2016.local:3000' + this.path.replace('public', '') + '/' + this.filename
      }
    },
    mounted: function() {
      var self = this
      var loader = new Image()
      loader.onload = () => {
        this.ratio = self.$el.clientWidth / loader.naturalWidth
      }
      loader.src = this.url
    }
  }
</script>

<style scoped>
  .photo {
    position: relative;
    width: 25%;
    float: left;
  }
  .photo img {
    max-width: 100%;
    height: auto;
  }
</style>
