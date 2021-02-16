<template>
  <div id="container-header">
    <Header />
  </div>

  <router-view />
  <div id="container-footer">
    <Footer />
  </div>
</template>

<script>
import Header from "./components/Header.vue";
import Footer from "./components/Footer.vue";
import Search from "./components/Search.vue";
import MusicPlayer from "./components/MusicPlayer.vue";
import Container from "./components/Container.vue";
import Home from "./components/Home.vue";

export default {
  name: "App",
  components: {
    Header,
    Home,
    Container,
    MusicPlayer,
    Search,
    Footer,
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
    ". . cs cs cs cs cs cp cp"
    ". . cs cs cs cs cs cp cp"
    ". . cs cs cs cs cs cp cp"
    ". . cs cs cs cs cs cp cp";
  grid-area: m;
}

#container-footer {
  display: grid;
  grid-area: f;
}

#container-search {
  grid-area: cs;
}

#container-player {
  grid-area: cp;
}
</style>
