<template>

  <div v-if="ifLoggedIn" id="container-main">
    <div id="container-search">
      <Search />
    </div>
    <div id="container-player">
      <MusicPlayer />
    </div>
  </div>
</template>

<script>
import Search from "./Search.vue";
import MusicPlayer from "./MusicPlayer.vue";
import {mapGetters} from 'vuex';

export default {
  name: "Container",
  components: {
    Search,
    MusicPlayer,
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
