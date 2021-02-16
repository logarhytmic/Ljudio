<template>
  <link
    rel="stylesheet"
    href="https://fonts.googleapis.com/icon?family=Material+Icons"
  />

  <div class="mPlayer">
    <h3>{{ fullname }}</h3>
    <div id="show-player">
      <div id="yt-player"></div>
    </div>
    <div class="bar">
      <vue-slider
        id="v-slider"
        ref="slider"
        v-model="value"
        @drag-end="onDragEnd"
        :min="0"
        :max="max"
        :contained="true"
        :drag-on-click="true"
        :tooltip="'active'"
        :tooltip-formatter="durationFormatter"
      ></vue-slider>
      <div class="controls">
        <em class="material-icons" title="Skip to previous video" @click="previousVideo">skip_previous</em>
        <em class="material-icons" title="Play video" @click="playVideo">play_arrow</em>
        <em class="material-icons" title="Pause video" @click="pauseVideo">pause</em>
        <em class="material-icons" title="Skip to next video" @click="nextVideo">skip_next</em>
        <em class="material-icons" title="Add current song to a playlist" @click="addToPlaylist">playlist_add</em>
        <em class="material-icons" title="Show the video player" id="toggle-video" @click="onVideoToggle"
          >tv</em
        >
        <br />
      </div>
    </div>
  </div>
</template>

<script>
import VueSlider from "vue-slider-component";
import "vue-slider-component/theme/material.css";

export default {
  name: "MusicPlayer",
  components: {
    VueSlider,
  },
  data() {
    return {
      player: null,
      value: 0,
      max: 1000,
      durationFormatter: (e) => this.formatDuration(e * 1000),
      videoTime: 0,
      intervalUpdater: null,
      fullname: "",
      showVideo: 0,
    };
  },

  methods: {
    onVideoToggle(event) {
      if (this.showVideo === 1) {
        event.target.style.color = "red";
        this.showVideo = 0;
        this.toggleVideoVisibility();
      } else {
        event.target.style.color = "green";
        this.showVideo = 1;
        this.toggleVideoVisibility();
      }
    },
    toggleVideoVisibility() {
      let playerDiv = document.getElementById("show-player");
      let toggleEm = document.getElementById("toggle-video");

      if (this.showVideo === 1) {
        playerDiv.style.visibility = "visible";
        toggleEm.title = "Hide the video player";
      } else {
        playerDiv.style.visibility = "hidden";
        toggleEm.title = "Show the video player";
      }
    },
    formatDuration(ms) {
      let s = (ms / 1000).toFixed(0);
      let m = Math.floor(s / 60);
      let h = "";

      if (m > 59) {
        h = Math.floor(m / 60);
        h = h >= 10 ? h : "0" + h;
        m = m - h * 60;
        m = m >= 10 ? m : "0" + m;
      }

      s = Math.floor(s % 60);
      s = s >= 10 ? s : "0" + s;

      return h != "" ? h + ":" + m + ":" + s : m + ":" + s;
    },
    playVideo() {
      this.player.playVideo();
    },
    pauseVideo() {
      this.player.pauseVideo();
    },
    nextVideo() {
      this.player.nextVideo();
    },
    previousVideo() {
      this.player.previousVideo();
    },
    onPlayerReady(event) {},
    onPlayerStateChange(event) {
      if (event.data != YT.PlayerState.PLAYING) {
        this.intervalUpdater = setInterval(this.updateTime, 1000);
      } else if (
        event.data != YT.PlayerState.PAUSED ||
        event.data != YT.PlayerState.ENDED
      ) {
        clearInterval(this.intervalUpdater);
      }
    },
    updateTime() {
      let oldTime = this.videoTime;
      if (this.player && this.player.getCurrentTime()) {
        this.videoTime = this.player.getCurrentTime();
      }

      if (this.videoTime !== oldTime) {
        this.onProgress(this.videoTime);
      }
    },
    onProgress(currentTime) {
      if (currentTime > 1) {
        this.value = currentTime;
      }
    },
    playSong(song) {
      this.player.loadVideoById(song.Id);
      this.value = 0;
      this.max = song.Duration / 1000;
      this.fullname = song.Originator + " - " + song.Name;
    },
    onDragEnd(event) {
      this.player.seekTo(this.$refs.slider.getValue(), true);
    },
  },

  async mounted() {
    this.player = new YT.Player("yt-player", {
      videoId: "",
      host: "https://www.youtube.com",
      playerVars: {
        autoplay: 0,
        controls: 0,
      },
      height: "300",
      width: "400",
      events: {
        onReady: this.onPlayerReady,
        onStateChange: this.onPlayerStateChange,
      },
    });

    document.getElementById("show-player").style.visibility = "hidden";
  },

  computed: {},
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
  padding-top: 47px;
}

.mPlayer > img:active {
  transform: scale(0.9);
}

.mPlayer > h3 {
  color: white;
}

#v-slider {
  margin-top: 5px;
  margin-right: 10px;
  margin-bottom: 5px;
  margin-left: 10px;
}

.yt-player {
  grid-area: v;
}

.bar {
  grid-area: b;
  width: 60%;
  margin: 0 auto;
  border: 1px solid #231123;
  box-shadow: 5px 5px 5px black;
}

.controls {
  color: white;
}

.controls > em {
  cursor: pointer;
}

.controls > em:hover {
  color: coral;
}

.controls > em:active {
  color: white;
}

#toggle-video {
  color: red;
}
</style>
