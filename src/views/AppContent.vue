<template>
  <div v-if="ifLoggedIn" id="container-main">
    <div id="container-search">
      <Search ref="search" v-on:play="onPlay" />
    </div>
    <div id="container-player">
      <MusicPlayer ref="mPlayer" />
    </div>
  </div>
</template>

<script>
import Search from "../components/Search.vue";
import MusicPlayer from "../components/MusicPlayer.vue";
import { mapGetters } from "vuex";

export default {
  name: "AppContent",
  components: {
    Search,
    MusicPlayer,
  },
  methods: {
    onPlay: function (song) {
      this.$refs.mPlayer.playSong(song);
    },
  },
  computed: {
    ifLoggedIn() {
      return this.$store.state.loggedIn;
    },
    ...mapGetters(["isLoggedIn"]),
  },
};
</script>

<style></style>
