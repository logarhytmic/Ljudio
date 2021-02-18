<template>
  <link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
  />
  <div id="current-playlist">
    <div id="current-playlist-results">
      <div class="div-header">
        <h3>Current Queue</h3>
        <div>
            <em @click="share_songs()" class="material-icons">share</em>
        </div>
      </div>
      <div
        class="song-card"
        v-for="song in get_songs"
        :key="song.id"
        @click="on_click(song)"
      >
        <div class="song-body">
          <span
            >{{ song.originator }} - {{ song.title }} [{{
              formatDuration(song.duration)
            }}]</span
          >
        </div>
        <div class="button-delete" @click="delete_song(song)">
          <em class="fa fa-times"></em>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      _data: {
        id: "",
        title: "",
        originator: "",
        duration: "",
      },
    };
  },
  computed: {
    get_songs() {
      return this.$store.state.songs;
    },
  },
  methods: {
    async delete_song(song) {
      const res = await fetch("/api/playlists/song", {
        method: "DELETE",
        cache: "no-cache",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(song),
      });
      const temp = await fetch(
        "/api/current-playlist/" + this.$store.state.currentPlaylist.id,
        {
          method: "GET",
          headers: {
            "Content-Type": "application/json",
          },
        }
      );
      this.$store.commit("addCurrentPlaylist", await temp.json());
    },

    async on_click(element) {
      // TODO when current song ends, set next one in songs[] to current
      // TODO how to make page react to slider reaching maximum
      // for (let i = this.get_songs().indexOf(element); i < this.get_songs().length; ++ i) {
      //     this.$store.commit("addSongToQueue", this.get_songs().indexOf(i));
      // }
      
      this.$store.commit("setCurrentSong", element);
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
    async share_songs() {
      let pl = prompt("Please input playlist id");
      const res = await fetch("/api/current-playlist/" + pl, {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
        },
      });

      this.$store.commit("addCurrentPlaylist", await res.json());
      console.log(this.$store.state.songs);
    },
  },
};
</script>

<style scoped>
#current-playlist {
  display: flex;
  flex-flow: column;
  color: white;
  width: 100%;
  height: 100%;
  user-select: none;
}

#current-playlist-results {
  border-bottom: 1px solid black;
  border-left: 1px solid black;
  color: white;
  text-align: left;
  height: 100%;
}

.div-header {
  display: flex;
  padding-left: 5px;
  padding-top: 3px;
  padding-bottom: 3px;
  border-bottom: 1px solid black;
}

#current-playlist-results > div:first-child {
  background-color: #351735;
}

#current-playlist-results > div:nth-child(2n + 2):active {
  background-color: #231123;
}

#current-playlist-results > div:nth-child(2n + 3) {
  background-color: #351735;
}

#current-playlist-results > div:nth-child(2n + 3):active {
  background-color: #231123;
}

.song-card {
  display: flex;
  justify-content: space-between;
  padding-left: 5px;
  padding-right: 10px;
  padding-top: 2px;
  padding-bottom: 2px;
  cursor: pointer;
  border-bottom: 1px solid black;
}

.song-body > span:hover {
  color: coral;
}

.song-body > span:hover {
  color: coral;
}

.button-delete > em:hover {
  color: coral;
}
</style>
