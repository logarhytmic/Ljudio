<template>
  <div id="playlists">
    <div id="playlist-results">
      <div class="div-header">
        <h3>My Playlists</h3>
        <span id="span-add-to-playlist">
          <em @click="addPlaylist" id="button-playlist-add" class="fa fa-plus"></em>
        </span>
      </div>
      <div
        class="playlist-card"
        v-for="playlist in get_playlist"
        v-bind:key="playlist.id"
        @click="fetch_songs(playlist)"
      >
        <div class="playlist-body" @click="fetch_songs(playlist)">
          <span>{{ playlist.title }}</span>
        </div>
        <div class="button-delete" @click="delete_playlist(playlist)">
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

    async delete_playlist(playlist) {
      let sure = confirm("Do you want to remove " + playlist.title + "?");
      if (sure) {
        const res = await fetch("/api/playlists/", {
          method: "DELETE",
          cache: "no-cache",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify(playlist),
        });
        this.fetch_playlists();
      }
    },
    
    async fetch_songs(playlist) {
      await this.$store.commit("setCurrentPlaylist", playlist);
      const res = await fetch("/api/current-playlist/" + playlist.id, {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
        },
      });

      this.$store.commit("addCurrentPlaylist", await res.json());
    },

    async addPlaylist() {
      let data = {
        title: prompt("Playlist name: ", "").trim(),
      };

      if (data && data.title) {
        await fetch("/api/playlists", {
          method: "POST",
          body: JSON.stringify(data),
          cache: "no-cache",
          headers: {
            "Content-Type": "application/json",
          },
        })
          .then((r) => r.json())
          .then((d) => {
            if (d.affectedRows > 0) {
              this.fetch_playlists();
            }
          })
          .catch((e) => {
            console.error("Error:", e);
          });
      }
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
  display: flex;
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

#playlist-results > div:nth-child(2n + 2):active {
  background-color: #231123;
}

#playlist-results > div:nth-child(2n + 3) {
  background-color: #351735;
}

#playlist-results > div:nth-child(2n + 3):active {
  background-color: #231123;
}

.playlist-card {
  display: flex;
  padding-left: 5px;
  padding-right: 10px;
  padding-top: 2px;
  padding-bottom: 2px;
  cursor: pointer;
  border-bottom: 1px solid black;
  justify-content: space-between;
}

.playlist-body > span:hover {
  color: coral;
}

.playlist-body > span:hover {
  color: coral;
}

.button-delete > em:hover {
  color: coral;
}

#span-add-to-playlist {
  padding-right: 10px;
  padding-top: 3px;
}

h3 {
  width: 100%;
}

#button-playlist-add {
  color: green;
  cursor: pointer;
}

#button-playlist-add:hover {
  color: coral;
}

#button-playlist-add:active {
  color: green;
}
</style>
