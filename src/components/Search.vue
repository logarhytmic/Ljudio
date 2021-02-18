<template>
  <link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
  />
  <link
    rel="stylesheet"
    href="https://fonts.googleapis.com/icon?family=Material+Icons"
  />

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
                (card.type == 'albums' ||
                  card.type == 'single' ||
                  card.type == 'ep') &&
                /^\d+$/.test(card.year)
              "
            >
              [{{ card.year }}]</span
            >
          </span>
        </div>
        <div class="card-playlist-add">
          <em @click="addToPlaylist(card)" class="material-icons"
            >playlist_add</em
          >
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      searchString: "",
    };
  },
  computed: {
    searchCards() {
      return this.$store.state.results;
    },
  },
  methods: {
    async addToPlaylist(song) {
      await this.$store.commit("addSongToQueue", song);
    },

    async getQueue() {
      console.table(await this.$store.state.queue);
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
      // Stores the song in the temporary queue, which is stored in the store.js under the queue array
      this.$store.commit("addSongToQueue", element);
      // Here you would want to call the playVideoById youtube api function with the elements Id
      if (element.type === "song") {
        this.$store.commit("setCurrentSong", element);
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

    async Search() {
      let str = this.searchString;

      if (str.trim().length > 0) {
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
#search {
  width: 100%;
  height: 100%;
}

#search-result {
  border: 1px solid black;
  /* border-bottom: 1px solid black;
  border-left: 1px solid black;
  border-right: 1px solid black; */
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
  padding-top: 7px;
  padding-bottom: 7px;
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
</style>
