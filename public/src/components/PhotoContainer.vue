<template>
  <div class="photo-container">
    <image-dialog :target="target" ref="dialog"></image-dialog>
    <md-layout md-gutter>
      <photo
              v-on:openImageDialog="openImageDialog"
              v-for="p in photos"
              :config="config"
              :key="p.id"
              :id="p.id"
              :photo="p"
              :filename="p.filename"
              :path="p.path"
              :created_at="p.created_at"
              :faces="p.faces"
      ></photo>
    </md-layout>

  </div>
</template>

<script>
  import axios from 'axios';
  import { mapGetters, mapActions } from 'vuex'

  import Photo from './Photo'
  import ImageDialog from './ImageDialog'

  export default {
    name: 'photoAPI-container',
    components: {
      Photo,
      ImageDialog
    },
    props: [ 'config', 'photos' ],
    data () {
      return {
        imageSrc: '',
        target: []
      }
    },
    methods: {
      openImageDialog: function(target) {
        this.target = target
        this.$refs['dialog'].$refs['alert'].open();
      }
    }
  }
</script>

<style scoped>
  .photo-container {
    overflow: hidden;
  }
</style>
