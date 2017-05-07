<template>
  <div class="bounds" :style="styleObject">
    <p class="bounds-txt" v-if="feelText">{{feelText}}</p>
  </div>
</template>

<script>

  import Utility from '../Utility'

  export default {
    name: 'bounds',
    props: [
      'id',
      'bounds',
      'ratio',
      'face'
    ],
    computed: {
      head: function () {
        return JSON.parse(this.bounds).head
      },
      x1: function () {
        return this.head[0].x * this.ratio
      },
      y1: function () {
        return this.head[0].y * this.ratio
      },
      x2: function () {
        return this.head[2].x * this.ratio
      },
      y2: function () {
        return this.head[2].y * this.ratio
      },
      color: function () {
        return Utility.getFaceColor(this.face)
      },
      feelText: function () {
        return Utility.getFaceText(this.face)
      },
      styleObject: function () {
        return {
          top: this.y1 + 'px',
          left: this.x1 + 'px',
          width: this.x2 - this.x1 + 'px',
          height: this.y2 - this.y1 + 'px',
          borderColor: this.color,
        }
      }
    },
  }
</script>

<style scoped>
  .bounds-outer {
    position: relative;
  }

  .bounds {
    position: absolute;
    border: 1px solid blue;
    background-color: rgba(0, 0, 0, 0.0);
  }

  .bounds-txt {
    padding: 0.3em 1em;
    position: absolute;
    top: -4em;
    left: 50%;
    font-size: 8px;
    font-weight: 700;
    color: #fff;
    transform: translateX(-50%);
    white-space: nowrap;
    background: rgba(0, 0, 0, 0.5);
    text-transform: uppercase;
  }
</style>
