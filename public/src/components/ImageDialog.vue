<template>
  <md-dialog-alert
          :md-content-html="image"
          ref="alert">
  </md-dialog-alert>
</template>

<script>

  import _ from 'underscore'

  export default {
    name: 'imageDialog',
    props: [
      'target',
    ],
    data () {
      return {}
    },
    computed: {
      image: function() {
        let faces = '';
        _.each(this.target.faces, (val, key) => {
          faces += val.anger
        })
        return '<div><img class="dialog-image" src="' + this.target.imageSrc + '" />' + faces + '</div>'
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
