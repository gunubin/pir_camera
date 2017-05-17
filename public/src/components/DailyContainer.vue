<template>
  <div class="daily-container" :style="containerStyle">

    <div v-for="(photos, title) in items">
      <md-subheader class="md-primary" :style="styleObject">{{title}}</md-subheader>
      <photoContainer :config="config" :photos="photos"></photoContainer>
    </div>

    <md-button @click.native="onClickMore" class="button md-raised md-primary">More</md-button>

  </div>
</template>

<script>
  import axios from 'axios';
  import {mapGetters, mapActions} from 'vuex'
  import PhotoContainer from './PhotoContainer'
  import _ from 'underscore'
  import Config from '../Config'

  export default {
    name: 'daily-container',
    components: {
      PhotoContainer
    },
    props: ['config'],
    data () {
      return {
        containerStyle: {
          height: window.innerHeight - 64 + 'px'
        },
        styleObject: {
          zIndex: 2,
          position: 'sticky',
          top: '0',
          backgroundColor: '#fff'
        }
      }
    },
    computed: mapGetters({
      items: 'allPhotos',
      storeFilter: 'filter',
    }),
    created: function () {
      this.$store.dispatch('getAllPhotos', this.storeFilter)
    },
    methods: {
      onClickMore: function () {
        console.log(this.$store);
        this.$store.dispatch('getMorePhotos', this.storeFilter)
      },
      handleWindowResize(event) {
        this.containerStyle.height = event.currentTarget.innerHeight - 64 + 'px' // toolbar 64
      },
    },
    beforeDestroy: function () {
      window.removeEventListener('resize', this.handleWindowResize)
    },
    mounted() {
      window.addEventListener('resize', this.handleWindowResize);
    },
  }
</script>

<style scoped>
  .daily-container {
    overflow-y: scroll;
    -webkit-overflow-scrolling: touch

  }
  .button {
    margin-top: 20px;
    margin-bottom: 40px;
  }
</style>
