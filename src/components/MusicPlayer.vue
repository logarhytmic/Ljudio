<template>
  <div class="mPlayer">
    <div class="playerwindow"></div>
    <div class="bar">[progress bar here]<br /></div>
    <div><img src="../assets/292-previous2.png" /></div>
    <div><img src="../assets/285-play3.png" /></div>
    <div><img src="../assets/287-stop2.png" /></div>
    <div><img src="../assets/293-next2.png" /></div>

    <youtube :video-id="videoId" ref="youtube" @playing="playing"></youtube>
    <button @click="playVideo">play</button>
  </div>
</template>

<script>
export default {
  name: "MusicPlayer",
  data() {
    return {
      videoId: 'lG0Ys-2d4MA'
    }
  },

methods: {
  playVideo() {
      this.player.playVideo()
    },
    playing() {
      console.log('\o/ we are watching!!!')
    }
},

  async mounted() {
    YT.ready(function () {
      this.player = new YT.Player("playerwindow", {
        videoId: "ZeSN4PntOos",
        host: "https://www.youtube.com",
        playerVars: {
          autoplay: 0,
          controls: 1,
        },
        height: "300",
        width: "400",
        events: {
          //'onStateChange': onPlayerStateChange
        },
      });
    });
  },

  computed: {
    playSong(id) {
      this.player.loadVideoById(id);
    },
    player() {
      return this.$refs.youtube.player
    }
  },
};
</script>

<style scoped>
.mPlayer {
  display: grid;
  grid-template-rows: auto;
  grid-template-columns: 1fr 1fr 1fr 1fr;
  grid-template-areas:
    "v v v v"
    "a a a a"
    "b b b b";
}

.mPlayer img:active {
  transform: scale(0.9);
  color: coral;
}
.playerwindow {
  grid-area: v;
}

.bar {
  grid-area: a;
}
</style>