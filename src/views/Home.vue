<template>
  <div id="container-home">
    <div id="container-header">
      <Header />
    </div>
    <div id="container-main">
      <h1>Home page</h1>
    </div>
    <div id="container-footer">
      <Footer />
    </div>
  </div>
</template>

<script>
import Header from "../components/Header.vue";
import Footer from "../components/Footer.vue";

export default {
  name: "Home",
  components: {
    Header,
    Footer,
  },
  methods: {},
};
</script>

<style scoped>
#container-home {
  display: grid;
  width: 100%;
  height: 100%;
  grid-template-columns: repeat(4, 1fr);
  grid-template-rows: 8% 1fr 8%;
  grid-template-areas:
    "he he he he"
    "me me me me"
    "fe fe fe fe"
    ;
}

#container-header {
  grid-area: he;
}

#container-main {
  grid-area: me;
}

#container-footer {
  grid-area: fe;
}
</style>
