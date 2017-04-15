<template>
  <md-layout md-flex-xsmall="50" md-flex="33">
    <md-card>

      <div class="card-media-outer">
        <p class="click-area" v-on:click="openImageDialog"></p>
        <face v-for="f in faces"
              :key="f.id"
              :face="f"
              :ratio="ratio"
        ></face>

        <md-card-media>
          <img :src="imageSrc"></img>
        </md-card-media>
      </div>

      <!--<md-card-header>-->
      <!--</md-card-header>-->

      <md-card-actions>
        <div class="md-subhead">
          <md-icon>access_time</md-icon>
          <span>{{created_at | moment('HH:mm')}}</span>
        </div>
        <md-button :class="{'md-warn': photo.favorite}" class="md-icon-button" @click.native="onClickFavorite">
          <md-icon>favorite</md-icon>
        </md-button>
      </md-card-actions>


    </md-card>
  </md-layout>
</template>

<script>

  import Face from './Face'

  export default {
    name: 'photo',
    props: [
      'config',
      'photo',
      'path',
      'filename',
      'created_at',
      'faces',
    ],
    components: {
      Face
    },
    data () {
      return {ratio: ''}
    },
    computed: {
      imageSrc: function () {
        return this.config.host + this.path.replace('public', '') + '/' + this.filename
      },
    },
    mounted: function () {
      let self = this
      let loader = new Image()
      loader.onload = () => {
        this.ratio = self.$el.clientWidth / loader.naturalWidth
      }
      loader.src = this.imageSrc
    },
    methods: {
      openImageDialog: function () {
        this.$emit('openImageDialog', this);
      },
      onClickFavorite: function () {
        this.$store.dispatch('setFavorite', this.photo)
      }
    }
  }
</script>

<style scoped>
  .card-media-outer {
    position: relative;
  }
  .click-area {
    z-index: 2;
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
  }
</style>
