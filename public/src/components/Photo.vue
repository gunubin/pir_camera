<template>
  <md-layout md-flex-xsmall="50" md-flex="33">
    <md-card>

      <div v-on:click="openImageDialog">
        <face v-for="f in faces"
              :key="f.id"
              :face="f"
              :ratio="ratio"
        ></face>

        <md-card-media>
          <md-image :md-src="imageSrc"></md-image>
        </md-card-media>
      </div>

      <!--<md-card-header>-->
      <div class="md-subhead">
        <md-icon>access_time</md-icon>
        <span>{{created_at | moment('HH:mm')}}</span>
      </div>
      <!--</md-card-header>-->

    </md-card>
  </md-layout>
</template>

<script>
  import Face from './Face'

  export default {
    name: 'photo',
    props: [
      'config',
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
        this.$emit('openImageDialog', this.imageSrc);
      }
    }
  }
</script>

<style scoped>
  .photo {
    position: relative;
  }

  .card-reservation {
    margin-top: 8px;
    display: flex;
    align-items: center;
    justify-content: space-around;
  }

  .md-icon {
    margin: 8px;
    color: rgba(#000, .54) !important;
  }
</style>
