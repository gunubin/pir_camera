<template>
  <transition name="fade">
    <div class="spinner">
      <md-spinner :md-size="150" md-indeterminate></md-spinner>
    </div>
  </transition>
</template>

<script>

  export default {
    name: 'spinner',
    props: [
      'config',
    ],
    components: {},
    data () {
      return {}
    },
    mounted: function () {
    },
    methods: {}
  }
</script>

<style scoped>
  .fade-enter-active, .fade-leave-active {
    transition: opacity .2s;
    transition-delay: 0.1s;
  }
  .fade-enter, .fade-leave-to /* .fade-leave-active in <2.1.8 */ {
    opacity: 0
  }
  .spinner {
    z-index: 5000;
    background-color: rgba(0, 0, 0, 0.4);
    position: absolute;
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
    height: 100%;
  }
</style>
