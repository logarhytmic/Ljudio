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
    <form id="form-search" @submit.prevent="Search()">
      <input
        v-model="searchString"
        id="input-search"
        type="search"
        alt="input-search"
        name="input-search"
        placeholder="search..."
      />
      <button id="button-search">
        <em class="fa fa-search"></em>
      </button>
    </form>

    <!-- Display search result -->
    <div id="search-result">
      <div v-for="card in searchCards" :key="card.Id" class="search-card">
        <div @click="onClick(card)" class="card-content">
          <span class="p-result">
            [{{ card.Type }}] {{ card.Originator }}
            <span v-if="card.Type != 'artist'"> - {{ card.Name }}</span>
            <span v-if="card.Type == 'song'">
              [{{ formatDuration(card.Duration) }}]</span
            >
            <span
              v-else-if="
                (card.Type == 'albums' ||
                  card.Type == 'single' ||
                  card.Type == 'ep') &&
                /^\d+$/.test(card.Year)
              "
            >
              [{{ card.Year }}]</span
            >
          </span>
        </div>
        <div class="card-playlist-add">
          <em @click="addToPlaylist(card)" class="material-icons"
            >playlist_add</em
          >
        </div>
      </div>
      <button
        title="This is just for testing. Click a couple of results then click this and check the console!"
        @click="getQueue"
        id="test"
      >
        Test
      </button>
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
      if (element.Type === "song") {
        this.$emit("play", element);
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
        Id: e.videoId,
        Type: e.type,
        Originator: e.artist.name,
        Name: e.name,
        Duration: e.duration,
      };

      return song;
    },

    getAlbumData(e) {
      let song = {
        Id: e.browseId,
        Type: e.type,
        Originator: e.artist,
        Name: e.name,
        Year: e.year,
      };

      return song;
    },

    getArtistData(e) {
      let song = {
        Id: e.browseId,
        Type: e.type,
        Originator: e.name,
      };

      return song;
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
  display: grid;
  grid-template-columns: repeat(9, 1fr);
  grid-template-rows: auto;
  grid-template-areas:
    "fr fr fr fr fr fr fr fr fr"
    "csr csr csr csr csr csr csr csr csr";
  padding-top: 10px;
}

#form-search {
  grid-area: fr;
}

#search-result {
  grid-area: csr;
  border: 1px solid #231123;
  margin-top: 1vh;
  color: white;
  min-height: 60vh;
  text-align: left;
}

#search-result > div:nth-child(odd) {
  background-color: #351735;
  border-left: 1px solid #231123;
  border-right: 1px solid #231123;
}

#search-result > div:nth-child(even) {
  border-left: 1px solid #351735;
  border-right: 1px solid #351735;
}

#search-result > div:nth-child(odd):active {
  background-color: #231123;
  border-left: 1px solid #351735;
  border-right: 1px solid #351735;
}

#search-result > div:nth-child(even):active {
  background-color: #351735;
  border-left: 1px solid #231123;
  border-right: 1px solid #231123;
}

.search-card {
  display: flex;
  padding-left: 5px;
  padding-right: 3px;
  justify-content: space-between;
  cursor: pointer;
}

.search-card > .card-content:hover > span {
  color: coral;
}

.search-card > .card-playlist-add > em {
  cursor: pointer;
}

.search-card > .card-playlist-add > em:hover {
  color: coral;
}

.search-card > .card-content {
  width: 100%;
}

input {
  background-color: transparent;
  box-shadow: none;
  /* border: none; */
  border: 1px solid #231123;
  padding: 1px;
  padding-left: 5px;
  max-width: 100%;
  text-align: left;
  color: white;
  font-family: "Roboto", "Noto", sans-serif;
  font-size: 16px;
  font-weight: 400;
  line-height: 24px;
  outline: 0;
  -webkit-appearance: none;
  -webkit-font-smoothing: antialiased;
}

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

button {
  box-shadow: none;
  border: 1px solid #3b203b;
  background-color: #3b203b;
  color: white;
  padding: 5px;
  padding-top: 6px;
  padding-left: 10px;
  padding-right: 10px;
  cursor: pointer;
}
</style>
