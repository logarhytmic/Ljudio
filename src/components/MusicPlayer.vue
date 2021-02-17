<template>
  <div class="mPlayer">
    <div id="yt-player"></div>
    <div class="bar">[progress bar here]<br /></div>
    <div class="buttons">
      <img src="../assets/292-previous2.png" @click="previousVideo" />
      <img src="../assets/285-play3.png" @click="playVideo" />
      <img src="../assets/287-stop2.png" @click="pauseVideo" />
      <img src="../assets/293-next2.png" @click="nextVideo" />
      <img src="../assets/playlist_add.png" />
    </div>
    <div class="volume"><img src="../assets/296-volume-medium.png" />
    <vue-slider ref="volume_slider" v-model="volume" v-bind="volume_options" 
    @change="setVolume(volume)"/></div>
  </div>
</template>

<script>
import VueSlider from 'vue-slider-component'
import 'vue-slider-component/theme/default.css'

export default {
  name: "MusicPlayer",
  data() {
    return {
      player: null,
      volume: 50,
      volume_options: {
        dotSize: 12,
        width: 350,
        height: 4,
        contained: false,
        direction: 'ltr',
        "drag-on-click": false,
      }
    };
  },
  components: {
    VueSlider
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
    setVolume() {
      this.player.setVolume(this.$refs.volume_slider.getValue());
    }
  },

  async mounted() {
    this.player = new YT.Player("yt-player", {
      videoId: "gd_WaGG12Mw",
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
  display: grid;
  grid-template-rows: auto;
  grid-template-columns: 400px;
  grid-template-areas:
    "v"
    "b"
    "c"
    "x";
}

.mPlayer img:active {
  transform: scale(0.9);
}

#yt-player {
  grid-area: v;
}

.bar {
  grid-area: b;
}

.buttons {
  grid-area: c;
}

.volume {
  grid-area: x;
  display: flex;
  justify-content: center;
}

.volume img {
  transform: scale(0.8);
  }
</style>