<template>
  <transition name="fade">
    <div class="photo-description-outer">
      <md-input-container md-inline class="photo-description">
        <md-icon>speaker_notes</md-icon>
        <label>Notes</label>
        <md-input @keyup.enter.native="onSubmit" @blur.native="onSubmit" v-model="description"></md-input>
      </md-input-container>
    </div>
  </transition>
</template>

<script>

  export default {
    name: 'description',
    props: [
      'config',
      'photo',
    ],
    components: {},
    data () {
      return {description: this.photo.description}
    },
    mounted: function () {
    },
    methods: {
      onSubmit: function () {
        this.$store.dispatch('updatePhoto', {photo: this.photo, params: {description: this.description}})
        this.$emit('enterDescription')
      },
    }
  }
</script>

<style scoped>
  .fade-enter-active, .fade-leave-active {
    transition: all .22s ease-in;
    /*transform: translateY(0%);*/
  }

  .fade-enter, .fade-leave-to {
    /*opacity: 0;*/
    transform: translateY(100%);
  }

  .photo-description-outer {
    /*opacity: 0.9;*/
    padding: 0 20px;
    z-index: 100;
    position: absolute;
    bottom: 0;
    left: 0;
    width: 100%;
    background-color: #fff;
    margin-bottom: 0;
  }

  .photo-description {
  }
</style>
