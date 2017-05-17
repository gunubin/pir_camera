<template>
    <md-sidenav class="md-left" ref="leftSidenav" @open="open('Left')" @close="close('Left')">
      <md-toolbar class="md-large">
        <div class="md-toolbar-container">
          <h3 class="md-title">感情で絞り込み</h3>
        </div>
      </md-toolbar>

      <md-list>
        <md-list-item>
          お気に入り
          <md-switch v-model="filter.favorite" id="blurred" class="md-primary" @change="filterChange"></md-switch>
        </md-list-item>

        <md-list-item>
          説明がある
          <md-switch v-model="filter.description" id="description" class="md-primary" @change="filterChange"></md-switch>
        </md-list-item>

        <md-list-item>
          顔認識がない
          <md-switch v-model="filter.noface" id="blurred" class="md-primary" @change="filterChange"></md-switch>
        </md-list-item>

        <md-list-item>
          ぼやけている
          <md-switch v-model="filter.blurred" id="blurred" class="md-primary" @change="filterChange"></md-switch>
        </md-list-item>
        <md-list-item>
          帽子
          <md-switch v-model="filter.headwear" id="blurred" class="md-primary"
                     @change="filterChange"></md-switch>
        </md-list-item>
        <md-list-item>
          楽しい
          <md-switch v-model="filter.joy" id="blurred" class="md-primary" @change="filterChange"></md-switch>
        </md-list-item>
        <md-list-item>
          悲しい
          <md-switch v-model="filter.sorrow" id="blurred" class="md-primary" @change="filterChange"></md-switch>
        </md-list-item>
        <md-list-item>
          驚き
          <md-switch v-model="filter.surprise" id="blurred" class="md-primary"
                     @change="filterChange"></md-switch>
        </md-list-item>
        <md-list-item>
          肌の露出
          <md-switch v-model="filter.underExposed" id="blurred" class="md-primary"
                     @change="filterChange"></md-switch>
        </md-list-item>
      </md-list>

    </md-sidenav>
</template>

<script>

  import {mapGetters, mapActions} from 'vuex'

  export default {
    name: 'Side',
    components: {},
    props: ['config'],
    data() {
      return {
        filter: {
          noface: false,
          description: false,
          blurred: false,
          headwear: false,
          joy: false,
          sorrow: false,
          surprise: false,
          underExposed: false,
        }
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
        this.$refs.leftSidenav.toggle();
      },
      open: function (ref) {
      },
      close: function (ref) {
      },
      filterChange: function () {
        setTimeout(() => {
          this.$store.dispatch('getAllPhotos', this.filter)
        }, 100)
      }
    }
  }
</script>

<style scoped>
</style>
