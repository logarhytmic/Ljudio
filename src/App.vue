<template>
  <div id="container-header">
    <Header />
  </div>
  <div id="container-main">
    <div id="container-playlists">
        <Playlists />
    </div>
    <div id="container-search">
      <Search />
    </div>
    <div id="container-player">
      <MusicPlayer />
    </div>
  </div>
  <div id="container-footer">
    <Footer />
  </div>
</template>

<script>
import Header from "./components/Header.vue";
import Search from "./components/Search.vue";
import Footer from "./components/Footer.vue";
import MusicPlayer from "./components/MusicPlayer.vue";
import Playlists from "./components/Playlists.vue";

//import Controllers from "./components/Controllers.vue";

export default {
  name: "App",
  components: {
    Header,
    Search,
    Footer,
    MusicPlayer,
    Playlists,
  },
};
</script>

<style>
* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

body {
  font-family: Arial, Helvetica, sans-serif;
  line-height: 1.4;
}

#app {
  display: grid;
  width: 100vw;
  height: 100vh;
  grid-template-columns: repeat(9, 1fr);
  grid-template-rows: auto;
  grid-template-areas:
    "h h h h h h h h h"
    "m m m m m m m m m"
    "f f f f f f f f f";
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}

#container-header {
  display: grid;
  grid-area: h;
}

#container-main {
  display: grid;
  grid-template-areas:
    "pl pl cs cs cs cs cs cp cp"
    "pl pl cs cs cs cs cs cp cp"
    "pl pl cs cs cs cs cs cp cp"
    "pl pl cs cs cs cs cs cp cp";
  grid-area: m;
}

#container-playlists {
  grid-area: pl;
}

#container-search {
  grid-area: cs;
}

#container-player {
  grid-area: cp;
}

#container-footer {
  display: grid;
  grid-area: f;
}
</style>
