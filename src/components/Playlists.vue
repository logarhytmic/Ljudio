<template>
  <div id="playlists">
    <div id="playlist-results">
      <div class="div-header">
        <h3>My Playlists</h3>
      </div>
      <div
        class="playlist-card"
        @click="fetch_songs(playlist.id)"
        v-bind:key="playlist.id"
        v-for="playlist in get_playlist"
      >
        <span>{{ playlist.title }}</span>
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
        user_id: "",
      },
    };
  },
  mounted() {
    this.fetch_playlists();
  },
  computed: {
    get_playlist() {
      return this.$store.state.playlists;
    },
  },
  methods: {
    async fetch_playlists() {
      const res = await fetch("/api/playlists", {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
        },
      });
      this.$store.commit("addPlaylists", await res.json());
    },

    async fetch_songs(id) {
      const res = await fetch("/api/current-playlist/" + id, {
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
#playlists {
  display: flex;
  flex-flow: column;
  color: white;
  height: 100%;
}

.div-header {
  padding-left: 5px;
  padding-top: 3px;
  padding-bottom: 3px;
  border-bottom: 1px solid black;
}

#playlist-results {
  border-top: 1px solid black;
  border-bottom: 1px solid black;
  border-left: 1px solid black;
  color: white;
  text-align: left;
  height: 100%;
  user-select: none;
}

#playlist-results > div:first-child {
    background-color: #351735;
}

#playlist-results > div:nth-child(2n+2):active {
  background-color: #231123;
}

#playlist-results > div:nth-child(2n+3) {
  background-color: #351735;
}

#playlist-results > div:nth-child(2n+3):active {
  background-color: #231123;
}

.playlist-card {
  display: flex;
  padding-left: 5px;
  padding-right: 5px;
  padding-top: 2px;
  padding-bottom: 2px;
  cursor: pointer;
  border-bottom: 1px solid black;
}

.playlist-card > span:hover {
  color: coral;
}

.playlist-card > span:hover {
  color: coral;
}
</style>
