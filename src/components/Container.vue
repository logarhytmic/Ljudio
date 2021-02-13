<template>
  <div v-if="!ifLoggedIn" id="container-player">
    <span class="components-player">
      <Search />
    </span>
    <span class="components-player">
      <MusicPlayer />
    </span>
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
