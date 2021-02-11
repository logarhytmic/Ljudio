<template>
  <div id="container-search">
    <form id="form-search" @submit.prevent="Search()">
      <input
        v-model="searchString"
        id="input-search"
        type="text"
        alt="input-search"
        name="input-search"
        placeholder="search..."
      />
      <button id="button-search">Search</button>
    </form>
    <div id="container-search-result">
      <span
        @click="Play(card)"
        class="p-result"
        v-for="card in searchCards"
        :key="card.Id"
      >
        [{{ card.Type }}] {{ card.Originator }}
        <span v-if="card.Type != 'artist'"> - {{ card.Name }}</span>
        <span v-if="card.Type == 'song'"> [{{ card.Duration }}]</span>
        <span
          v-else-if="
            card.Type == 'albums' || card.Type == 'single' || card.Type == 'ep'
          "
        >
          [{{ card.Year }}]</span
        ><br />
      </span>
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
    async Play(element) {
      // Examples of using the click events element (element refering to the song/album/artist clicked)
      console.log("To get the clicked element: element == ", element);
      console.log("Example of getting the elements video/browse- Id: element.Id == ", element.Id);
      console.log("Example of getting the elements Type: element.Type == ", element.Type);
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
        } else if (e.type === "album" || e.type === "single" || e.type === "ep") {
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
          let data = await this.FetchData("/api/yt/albums/" + str.substring(7).trim());

          this.$store.commit("addResults", await this.iterRawData(data));
        } else if (str.startsWith("@artists")) {
          let data = await this.FetchData("/api/yt/artists/" + str.substring(8).trim());

          this.$store.commit("addResults", await this.iterRawData(data));
        } else if (str.startsWith("@songs")) {
          let data = await this.FetchData("/api/yt/songs/" + str.substring(6).trim());

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
#container-search {
  display: grid;
  grid-template-columns: repeat(9, 1fr);
  grid-template-rows: auto;
  grid-template-areas:
    "fr fr fr fr fr fr fr fr fr"
    "csr csr csr csr csr csr csr csr csr";
}

#form-search {
  grid-area: fr;
}

#container-search-result {
  grid-area: csr;
}

span {
  cursor: pointer;
}

span:hover {
  color: red;
}
</style>
