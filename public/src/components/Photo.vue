<template>
  <md-layout class="photo-layout" md-flex-xsmall="100" md-flex="33">
    <md-card>
      <md-card-media-cover md-solid>

        <div class="card-media-outer">
          <p class="click-area" v-on:click="openImageDialog"></p>
          <face v-for="f in faces"
                :key="f.id"
                :face="f"
                :ratio="ratio"
          ></face>

          <md-card-media><img :src="imageSrc"/></md-card-media>
        </div>

        <md-card-area class="md-card-area">

          <md-card-header v-if="photo.description">
            <div class="md-subhead">{{photo.description}}</div>
          </md-card-header>

          <md-card-actions>

            <md-button>
              <md-icon>access_time</md-icon>
              <span>{{created_at | moment('HH:mm')}}</span>
            </md-button>

            <md-button @click.native="seen = !seen">
              <md-icon>message</md-icon>
              コメント
            </md-button>

            <md-button :class="{'md-warn': photo.favorite}" @click.native="onClickFavorite">
              <md-icon>favorite</md-icon>
              お気に入り
            </md-button>

          </md-card-actions>
        </md-card-area>

      </md-card-media-cover>

      <description :photo="photo" v-if="seen" v-on:enterDescription="seen = false"></description>

    </md-card>
  </md-layout>
</template>

<script>

  import Face from './Face'
  import Description from './Description'

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
      Face,
      Description
    },
    data () {
      return {
        seen: false,
        ratio: '',
        showDescription: false,
      }
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
  .md-card {
    overflow: hidden;
  }
  .card-media-outer {
    position: relative;
  }

  .md-card-area {
    top: 0 !important;
    bottom: auto !important;
    text-align: left;
  }

  .click-area {
    z-index: 2;
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    padding: 0;
    margin: 0;
  }
</style>
