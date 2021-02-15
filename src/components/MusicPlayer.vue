<template>
  <div class="mPlayer">
    <div id="yt-player"></div>
    <div class="bar">[progress bar here]<br /></div>
    <div>
      <img src="../assets/292-previous2.png" @click="previousVideo" />
      <img src="../assets/285-play3.png" @click="playVideo" />
      <img src="../assets/287-stop2.png" @click="pauseVideo" />
      <img src="../assets/293-next2.png" @click="nextVideo" />
      <img src="../assets/playlist_add.png" />
    </div>
  </div>
</template>

<script>
export default {
  name: "MusicPlayer",
  data() {
    return {
      player: null,
    };
  },

  methods: {
    playVideo() {
      this.player.playVideo();
    },
    pauseVideo() {
      this.player.pauseVideo();
    },
    nextsVideo() {
      this.player.nextideo();
    },
    previousVideo() {
      this.player.previousVideo();
    },
  },

  async mounted() {
    this.player = new YT.Player("yt-player", {
      videoId: "ZeSN4PntOos",
      host: "https://www.youtube.com",
      playerVars: {
        autoplay: 0,
        controls: 0,
      },
      height: "300",
      width: "400",
      events: {
        //'onStateChange': onPlayerStateChange
      },
    });
  },

  computed: {
    playSong(id) {
      this.player.loadVideoById(id);
    },
  },

  props: {},
};
</script>

<style scoped>
.mPlayer {
  grid-template-rows: auto;
  grid-template-columns: 1fr 1fr 1fr 1fr 1fr;
  grid-template-areas:
    "v v v v v"
    "b b b b b"
    "c c c c c";
}

.mPlayer img:active {
  transform: scale(0.9);
}

.yt-player {
  grid-area: v;
}

.bar {
  grid-area: b;
}
</style>