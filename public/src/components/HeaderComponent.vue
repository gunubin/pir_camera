<template>
    <md-toolbar>

      <md-button class="md-icon-button" @click.native="toggleLeftSidenav">
        <md-icon>menu</md-icon>
      </md-button>

      <h2 class="md-title" style="flex: 1;">おまめカメラ</h2>
<!--
      <md-button class="md-icon-button">
        <md-icon>delete</md-icon>
      </md-button>
-->

      <md-button class="md-icon-button" @click.native="onClickCalender">
        <md-icon>date_range</md-icon>
      </md-button>


    </md-toolbar>


</template>

<script>

  import {mapGetters, mapActions} from 'vuex'


  export default {
    name: 'headerComponent',
    components: {},
    props: ['config'],
    data() {
      return {
      }
    },
    computed: mapGetters({
      storeFilter: 'filter',
    }),
    mounted() {
      this.$store.dispatch('setFilter', this.storeFilter)
    },
    methods: {
      toggleLeftSidenav: function () {
        this.$emit('clickMenuBtn')
      },
      onClickCalender: function() {
        this.$emit('onClickCalender', this);
      }
    }
  }
</script>

<style scoped>
</style>
