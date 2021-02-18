<template>
  <link
    rel="stylesheet"
    href="https://fonts.googleapis.com/icon?family=Material+Icons"
  />
  <div class="mPlayer">
    <div id="mPlayer-header">
      <span id="span-now-playing">Now playing: </span>
      <span id="span-song-fullname">{{ fullname }}</span>
    </div>
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
        <em
          class="material-icons"
          title="Skip to previous video"
          @click="previousVideo"
          >skip_previous</em
        >
        <em class="material-icons" title="Play video" @click="playVideo"
          >play_arrow</em
        >
        <em class="material-icons" title="Pause video" @click="pauseVideo"
          >pause</em
        >
        <em class="material-icons" title="Skip to next video" @click="nextVideo"
          >skip_next</em
        >
        <em
          class="material-icons"
          title="Add current song to a playlist"
          @click="addToPlaylist"
          >playlist_add</em
        >
        <em
          class="material-icons"
          title="Show the video player"
          id="toggle-video"
          @click="onVideoToggle"
          >tv</em
        >
      </div>
      <div class="volume">
        <em id="vol" class="material-icons" title="Toggle mute" @click="onMuteToggle"
          >volume_up</em
        >
        <vue-slider
          ref="volume_slider"
          v-model="volume"
          v-bind="volume_options"
          @change="setVolume(volume)"
          tooltip-placement="bottom"
        />
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
      volume: 50,
      volume_options: {
        dotSize: 12,
        width: 350,
        height: 4,
        contained: false,
        direction: "ltr",
        "drag-on-click": false,
      },
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
    onMuteToggle(event) {
      if (this.player.isMuted()) {
        this.player.unMute();
        event.target.style.color = "white";
      } else {
        this.player.mute();
        event.target.style.color = "dimgray";
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
    setVolume() {
      this.player.setVolume(this.$refs.volume_slider.getValue());
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
      this.player.loadVideoById(song.ytid);
      this.value = 0;
      this.max = song.duration / 1000;
      this.fullname = song.originator + " - " + song.title;
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
      height: "400",
      width: "600",
      events: {
        onReady: this.onPlayerReady,
        onStateChange: this.onPlayerStateChange,
      },
    });

    document.getElementById("show-player").style.visibility = "hidden";
  },

  computed: {
    currentSong() {
      return this.$store.state.currentSong;
    },
  },

  watch: {
    currentSong(song) {
      this.playSong(song);
    },
  },
};
</script>

<style scoped>
.mPlayer {
  border-bottom: 1px solid black;
  border-right: 1px solid black;
  height: 100%;
}

.mPlayer > img:active {
  transform: scale(0.9);
}

#mPlayer-header {
  display: flex;
  justify-content: space-between;
  color: white;
  padding-top: 4px;
  padding-bottom: 3px;
  border-top: 1px solid black;
  border-bottom: 1px solid black;
  border-right: 1px solid black;
  margin-bottom: 8px;
  background-color: #351735;
}

.show-player {
  margin-top: 20px;
}

#v-slider {
  margin-top: 5px;
  margin-right: 10px;
  margin-bottom: 5px;
  margin-left: 10px;
}

.yt-player {
}

.bar {
  width: 100%;
  border-top: 1px solid black;
  border-bottom: 1px solid black;
  border-right: 1px solid black;
  box-shadow: 5px 5px 5px black;
  background-color: #351735;
}

.controls {
  color: white;
  user-select: none;
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

#span-now-playing {
  padding-left: 10px;
  font-size: 18px;
  text-decoration: underline;
}

#span-song-fullname {
  padding-right: 10px;
  font-size: 18px;
}

.volume {
  grid-area: x;
  display: flex;
  justify-content: center;
  color: white;
  padding: 0px 20px 10px 0px;
}

.volume > em {
  margin-right: 10px;
  margin-left: 10px;
  cursor: pointer;
}

.volume > em:hover {
  color: coral;
}

.volume > em:active {
  color: white;
}


#vol
{
  font-size: 16px;
}
</style>
