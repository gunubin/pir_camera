<template>
  <div class="photo-container">
    <image-dialog :imageSrc="imageSrc" ref="dialog"></image-dialog>
    <md-layout md-gutter>
      <photo
              v-on:openImageDialog="openImageDialog"
              v-for="p in photos"
              :config="config"
              :key="p.id"
              :id="p.id"
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
    name: 'photo-container',
    components: {
      Photo,
      ImageDialog
    },
    props: [ 'config', 'photos' ],
    data () {
      return {
        imageSrc: ''
      }
    },
    methods: {
      openImageDialog: function(imageSrc) {
        this.imageSrc = imageSrc;
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
