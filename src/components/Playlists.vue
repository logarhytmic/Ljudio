<template>
  <div id="playlists">
    <div id="playlist-results">
      <div class="div-header">
        <h3>My Playlists</h3>
        <span id="span-add-to-playlist">
          <em
            @click="addPlaylist"
            id="button-playlist-add"
            class="fa fa-plus"
          ></em>
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
        <div class="playlist-controls">
          <div class="playlist-share" @click="displayShareCode(playlist.extid)">
            <span class="material-icons">publish</span>
          </div>
          <div class="button-delete" @click="delete_playlist(playlist)">
            <em class="fa fa-times"></em>
          </div>
        </div>
      </div>
    </div>
  </div>

  <vue-final-modal
    v-model="showModal"
    classes="modal-container"
    content-class="modal-content"
  >
    <span class="modal__title"></span>
    <form @submit.prevent="">
      <div class="modal__content">
        <label ref="modalLabel" id="modal-p"
          >Copy this code and share it with friends and they'll be able to
          import your awesome playlist!</label
        >
        <div class="container-input">
          <input
            type="text"
            name="code"
            id="input-code"
            v-model="playlistCode"
            disabled
          />
        </div>
      </div>
      <div class="modal__action">
        <div class="button_base b12_3d_glitch">
          <div></div>
          <div @click.prevent="showModal = false">Ok</div>
        </div>
      </div>
    </form>
  </vue-final-modal>
</template>

<script>
export default {
  data() {
    return {
      showModal: false,
      playlistCode: "",
      _data: {
        id: "",
        title: "",
        user_id: "",
        ext_id: "",
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
    displayShareCode(code) {
      this.playlistCode = code;
      this.showModal = true;
    },
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
      let promptTitle = prompt("Playlist name: ", "");

      if (promptTitle && promptTitle.trim()) {
        let data = {
          title: promptTitle.trim(),
          ext_id: await this.generateExtId(),
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
      }
    },
    async generateExtId() {
      const n = [
        "0",
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        "a",
        "b",
        "c",
        "d",
        "e",
        "f",
        "g",
        "h",
        "i",
        "j",
        "k",
        "l",
        "m",
        "n",
        "o",
        "p",
        "q",
        "r",
        "s",
        "t",
        "u",
        "v",
        "w",
        "x",
        "y",
        "z",
        "A",
        "B",
        "C",
        "D",
        "E",
        "F",
        "G",
        "H",
        "I",
        "J",
        "K",
        "L",
        "M",
        "N",
        "P",
        "Q",
        "R",
        "S",
        "T",
        "U",
        "V",
        "W",
        "X",
        "Y",
        "Z",
      ];

      let r = "";

      for (let i = 0; i < 18; i++) {
        r += n[Math.floor(Math.random() * n.length)];
      }

      return r;
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

.playlist-share {
  padding-right: 2px;
}

.playlist-share > span {
  font-size: 18px;
}

.playlist-share > span:hover {
  color: coral;
}

.playlist-controls {
  display: flex;
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

/* MODAL RELATED CSS */
.container-input {
  padding-bottom: 5px;
}

/* ==== Modal CSS ==== */

:deep(.modal-container) {
  display: flex;
  justify-content: center;
  align-items: center;
}

:deep(.modal-content) {
  position: relative;
  display: flex;
  flex-direction: column;
  max-height: 90%;
  margin: 0 1rem;
  padding: 1rem;
  border: 1px solid coral;
  border-radius: 0.25rem;
  background: #231123;
}

.modal__title {
  margin: 0 2rem 0 0;
  font-size: 1.5rem;
  font-weight: 700;
}

.modal__content {
  flex-grow: 1;
  overflow-y: auto;
  color: black;
}

.modal__action {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-shrink: 0;
  /* padding: 1rem 0 0; */
}

.modal__close {
  position: absolute;
  top: 0.5rem;
  right: 0.5rem;
}
/* END OF MODAL RELATED CSS */
</style>
