<template>
  <!-- Search input and button -->
  <div id="search">
    <!-- Display search result -->
    <div id="search-result">
      <div id="div-input">
        <form id="form-search" @submit.prevent="Search()">
          <input
            v-model="searchString"
            id="input-search"
            type="search"
            alt="input-search"
            name="input-search"
            placeholder="search..."
          />
          <div id="div-input-search">
            <button id="button-search">
              <em class="fa fa-search"></em>
            </button>
          </div>
        </form>
      </div>
      <div v-for="card in searchCards" :key="card.ytid" class="search-card">
        <div @click="onClick(card)" class="card-content">
          <span class="p-result">
            [{{ card.type }}] {{ card.originator }}
            <span v-if="card.type != 'artist'"> - {{ card.title }}</span>
            <span v-if="card.type == 'song'">
              [{{ formatDuration(card.duration) }}]</span
            >
            <span
              v-else-if="
                (card.type == 'album' ||
                  card.type == 'single' ||
                  card.type == 'ep') &&
                /^\d+$/.test(card.year)
              "
            >
              {{ card.name }} [{{ card.year }}]</span
            >
          </span>
        </div>
        <div class="card-playlist-add">
          <em @click="showAddModal(card)" class="material-icons"
            >playlist_add</em
          >
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
          >Choose the playlist to save song to</label
        >
        <div class="container-input">
          <select name="playlists" id="select-playlist">
            <option
              v-for="(playlist, i) in getPlaylists"
              :key="i"
              :value="JSON.stringify(playlist)"
            >
              {{ playlist.title }}
            </option>
          </select>
        </div>
      </div>
      <div class="modal__action">
        <div class="button_base b12_3d_glitch">
          <div></div>
          <div @click.prevent="addToPlaylist">Add</div>
        </div>
        <div class="button_base b12_3d_glitch">
          <div></div>
          <div @click.prevent="showModal = false">Cancel</div>
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
      searchString: "",
      song: "",
    };
  },

  computed: {
    searchCards() {
      return this.$store.state.results;
    },

    getPlaylists() {
      return this.$store.state.playlists;
    },
  },

  methods: {
    showAddModal(song) {
      this.song = song;
      this.showModal = true;
    },

    async addToPlaylist() {
      let e = document.getElementById("select-playlist");
      let playlist = e.options[e.selectedIndex].value;

      await fetch("/api/playlists/song", {
        method: "POST",
        cache: "no-cache",
        headers: {
          "Content-type": "application/json",
        },
        body: JSON.stringify([playlist, JSON.stringify(this.song)]),
      })
        .then((r) => r.json())
        .then((d) => {
          if (d.affectedRows > 0) {
            this.showModal = false;
          }
        })
        .catch((e) => {
          console.error("Error:", e);
        });
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

    async onClick(element) {
      if (element.type === "song") {
        this.$store.commit("setCurrentSong", element);
      } else if (
        element.type === "album" ||
        element.type === "single" ||
        element.type === "ep"
      ) {
        let albumRes = await this.FetchData("/api/yt/album/" + element.id);

        this.$store.commit(
          "addResults",
          await this.iterRawAlbumData(albumRes.tracks)
        );
      } else if (element.type === "artist") {
        //
      }
    },

    async FetchData(url) {
      const res = await fetch(url, {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
        },
      });

      return await res.json();
    },

    getSongData(e) {
      let song = {
        id: e.videoId,
        ytid: e.videoId,
        type: e.type,
        originator: e.artist.name,
        title: e.name,
        duration: e.duration,
      };

      return song;
    },

    getAlbumData(e) {
      let album = {
        id: e.browseId,
        type: e.type,
        originator: e.artist,
        name: e.name,
        year: e.year,
      };

      return album;
    },

    getArtistData(e) {
      let artist = {
        id: e.browseId,
        type: e.type,
        originator: e.name,
      };

      return artist;
    },

    async iterRawData(data) {
      let results = [];

      data.content.forEach((e) => {
        if (e.type === "song") {
          // save e as song object
          results.push(this.getSongData(e));
        } else if (e.type === "artist") {
          // save e as artist object
          results.push(this.getArtistData(e));
        } else if (
          e.type === "album" ||
          e.type === "single" ||
          e.type === "ep"
        ) {
          // save e as a type of album object
          results.push(this.getAlbumData(e));
        }
      });

      return results;
    },

    async iterRawAlbumData(data) {
      let results = [];
      let tempSong = {};

      data.forEach((e) => {
        tempSong = {
          id: e.videoId,
          ytid: e.videoId,
          type: "song",
          originator: e.artistNames,
          title: e.name,
          duration: e.duration,
        };

        results.push(tempSong);
      });

      return results;
    },

    async Search() {
      let str = this.searchString;

      if (str.trim()) {
        if (str.startsWith("@albums")) {
          let data = await this.FetchData(
            "/api/yt/albums/" + str.substring(7).trim()
          );

          this.$store.commit("addResults", await this.iterRawData(data));
        } else if (str.startsWith("@artists")) {
          let data = await this.FetchData(
            "/api/yt/artists/" + str.substring(8).trim()
          );

          this.$store.commit("addResults", await this.iterRawData(data));
        } else if (str.startsWith("@songs")) {
          let data = await this.FetchData(
            "/api/yt/songs/" + str.substring(6).trim()
          );

          this.$store.commit("addResults", await this.iterRawData(data));
        } else {
          let data = await this.FetchData("/api/yt/search/" + str);

          this.$store.commit("addResults", await this.iterRawData(data));
        }
      }
    },
  },
};
</script>

<style scoped>
label {
  color: white;
}

#search {
  width: 100%;
  height: 100%;
}

#search-result {
  border: 1px solid black;
  color: white;
  text-align: left;
  user-select: none;
  height: 100%;
}

#search-result > div:first-child {
  cursor: default;
  background-color: #351735;
}

#search-result > div:nth-child(2n + 2):active {
  background-color: #231123;
}

#search-result > div:nth-child(2n + 3) {
  background-color: #351735;
}

#search-result > div:nth-child(2n + 3):active {
  background-color: #231123;
}

.search-card {
  display: flex;
  padding-left: 5px;
  padding-right: 3px;
  cursor: pointer;
  border-bottom: 1px solid black;
}

.search-card > .card-content:hover > span {
  color: coral;
}

.search-card > .card-playlist-add {
  /* font-size: 12px; */
}

.search-card > .card-playlist-add > em {
  user-select: none;
  cursor: pointer;
}

.search-card > .card-playlist-add > em:hover {
  color: coral;
}

.search-card > .card-content {
  width: 100%;
}

#div-input {
  display: flex;
  border-bottom-width: 0px;
  padding-bottom: 0px;
  padding-left: 5px;
  padding-right: 3px;
  justify-content: space-between;
  border-bottom: 1px solid black;

  cursor: pointer;
}

#div-input > #form-search {
  display: grid;
  grid-template-columns: 99% 1%;
  grid-template-rows: auto;
  grid-template-areas: "l r";
}

#div-input > #form-search > input {
  grid-area: l;
  background-color: transparent;
  box-shadow: none;
  border: none;
  text-align: left;
  color: white;
  font-family: "Roboto", "Noto", sans-serif;
  font-size: 16px;
  font-weight: 400;
  line-height: 24px;
  outline: 0;
  -webkit-appearance: none;
  -webkit-font-smoothing: antialiased;
  height: 100%;
  padding-top: 0px;
  padding-bottom: 12px;
}

/* Removing especially Mozilla autofill styling etc */
input:-webkit-autofill,
input:-webkit-autofill:hover,
input:-webkit-autofill:focus,
textarea:-webkit-autofill,
textarea:-webkit-autofill:hover,
textarea:-webkit-autofill:focus,
select:-webkit-autofill,
select:-webkit-autofill:hover,
select:-webkit-autofill:focus {
  -webkit-text-fill-color: white;
  transition: background-color 5000s ease-in-out 0s;
}

#form-search > #div-input-search {
  grid-area: r;
}

#form-search > #div-input-search > button {
  box-shadow: none;
  border: none;
  border-left: 1px solid black;
  border-right: 1px solid black;
  background-color: #3b203b;
  color: white;
  padding-left: 6px;
  padding-right: 6px;
  height: 100%;
  cursor: pointer;
}

#form-search > #div-input-search > button:active {
  background-color: #351735;
}

/* MODAL RELATED CSS */
@import url("https://fonts.googleapis.com/css?family=Roboto+Condensed");

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

/* SELECT CSS */

/* SELECT CSS END */
</style>
