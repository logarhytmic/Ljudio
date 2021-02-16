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

export default {
  name: "App",
  components: {
    Header,
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
  grid-template-rows: 10vh auto;
  grid-template-areas:
    "h h h h h h h h h"
    "m m m m m m m m m"
    "m m m m m m m m m"
    "m m m m m m m m m"
    "m m m m m m m m m"
    "m m m m m m m m m"
    "m m m m m m m m m"
    "m m m m m m m m m"
    "f f f f f f f f f";
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
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
  background: #160b16;
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
