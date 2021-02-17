<template>
  <div v-if="ifLoggedIn" id="container-main">
    <div id="container-playlists">
      <Playlists />
    </div>
    <div id="container-search">
      <Search ref="search" />
    </div>
    <div id="container-player">
      <MusicPlayer ref="mPlayer" />
    </div>
    <div id="container-current">
      <CurrentPlaylist />
    </div>
  </div>
</template>

<script>
import Search from "../components/Search.vue";
import MusicPlayer from "../components/MusicPlayer.vue";
import { mapGetters } from "vuex";
import Playlists from "../components/Playlists.vue";
import CurrentPlaylist from "../components/CurrentPlaylist.vue";

export default {
  name: "AppContent",
  components: {
    Search,
    MusicPlayer,
    Playlists,
    CurrentPlaylist,
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
