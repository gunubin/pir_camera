<template>
  <div class="bounds" :style="styleObject">
  </div>
</template>

<script>
  export default {
    name: 'bounds',
    props: [
      'id',
      'bounds',
      'ratio',
      'face'
    ],
    computed: {
      head: function() {
        return JSON.parse(this.bounds).head
      },
      x1: function() {
        return this.head[0].x * this.ratio
      },
      y1: function() {
        return this.head[0].y * this.ratio
      },
      x2: function() {
        return this.head[2].x * this.ratio
      },
      y2: function() {
        return this.head[2].y * this.ratio
      },
      color: function() {
        switch(this.face.joy) {
          case 'VERY_LIKEY':
            return '##FF0033'
          case 'LIKELY':
            return '#FF33FF'
          case 'POSSIBLE':
            return '#FF66FF'
          case 'UNLIKELY':
            return '#FF99FF'
          case 'VERY_UNLIKELY':
            return '#FFCCFF'
          case 'NKNOWN':
            return '#FFFFFF'
        }
        return 'rgba(255,255,255, 0.4)'
      },
      styleObject: function() {
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
  .bounds {
    position: absolute;
    border: 1px solid blue;
    background-color: rgba(0, 0, 0, 0.0);
  }
</style>
