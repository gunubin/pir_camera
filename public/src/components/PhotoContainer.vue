<template>
  <div class="photo-container">
    <photo
        v-for="p in photos"
        :key="p.id"
        :id="p.id"
        :filename="p.filename"
        :path="p.path"
        :faces="p.faces"
    ></photo>
  </div>
</template>

<script>
import axios from 'axios';
import Photo from './Photo'

export default {
  name: 'photo-container',
  components: {
    Photo
  },
  data () {
    return {
      photos: []
    }
  },
  created: function() {
    axios.get('http://mbp2016.local:3000/photos/').then((res) => {
      for(let i=0; i<res.data.length; i++) {
        this.photos.push(res.data[i])
      }
    })
  }
}
</script>

<style scoped>
</style>
