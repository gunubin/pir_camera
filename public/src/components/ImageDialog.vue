<template>
  <md-dialog-alert
          :md-content-html="image"
          ref="alert">
  </md-dialog-alert>
</template>

<script>

  export default {
    name: 'imageDialog',
    props: [
      'imageSrc',
    ],
    data () {
      return {}
    },
    computed: {
      image: function() {
        return '<img class="dialog-image" src="' + this.imageSrc + '" />'
      }
    },
    mounted: function () {
    }
  }
</script>

<style >
  .md-dialog {
    max-width: 640px;
    width: 97%;
  }
  .md-dialog-content {
    padding: 0;
    padding-top: 0 !important;
  }
  .dialog-image {
    width: 100%;
    height: auto;
  }
</style>
