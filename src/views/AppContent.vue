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
    <div id="container-current-playlist">
      <CurrentPlaylist />
    </div>
    <div id="container-user-controls">
      <div id="controls">
        <UserAuth />
      </div>
    </div>
  </div>
</template>

<script>
import Search from "../components/Search.vue";
import MusicPlayer from "../components/MusicPlayer.vue";
import { mapGetters } from "vuex";
import Playlists from "../components/Playlists.vue";
import CurrentPlaylist from "../components/CurrentPlaylist.vue";
import Header from "../components/Header.vue";
import UserAuth from "../components/UserAuth.vue";

export default {
  name: "AppContent",
  components: {
    Search,
    MusicPlayer,
    Playlists,
    CurrentPlaylist,
    Header,
    UserAuth,
  },
  computed: {
    ifLoggedIn() {
      return this.$store.state.loggedIn;
    },
    ...mapGetters(["isLoggedIn"]),
  },
};
</script>

<style>
#container-main {
  display: grid;
  height: 100%;
  grid-template-columns: 15% repeat(8, 1fr);
  grid-template-rows: 8vh auto;
  grid-template-areas:
    "pl cs cs cs cs cs cp cp cp"
    "pl cs cs cs cs cs cp cp cp"
    "pl cs cs cs cs cs cp cp cp"
    "cl cs cs cs cs cs cp cp cp"
    "cl cs cs cs cs cs cp cp cp"
    "cl cs cs cs cs cs cp cp cp"
    "cl cs cs cs cs cs cp cp cp"
    "cl cs cs cs cs cs cu cu cu";
  background: #160b16;
}

#container-header {
  grid-area: h;
}

#container-playlists {
  grid-area: pl;
}

#container-current-playlist {
  grid-area: cl;
}

#container-search {
  grid-area: cs;
}

#container-player {
  grid-area: cp;
}

#container-user-controls {
  grid-area: cu;
}

#controls {
  height: 100%;
  border-right: 1px solid black;
  border-bottom: 1px solid black;
}

@media all and (max-width: 800px) {
  #container-main {
  display: grid;
  height: 100%;
  grid-template-columns: 1fr 1fr;
  grid-template-areas:
    "pl pl"
    "pl pl"
    "pl pl"
    "cl cl"
    "cl cl"
    "cl cl"
    "cs cs"
    "cs cs"
    "cs cs"
    "cs cs"
    "cp cp"
    "cp cp"
    "cp cp"
    "cp cp"
    "cu cu";
  background: #160b16;
}
}

@media all and (max-width: 1700px) and (min-width: 800px) {
  #container-main {
  display: grid;
  height: 100%;
  grid-template-columns: 1fr 1fr;
  grid-template-areas:
    "pl pl cl cl"
    "pl pl cl cl"
    "pl pl cl cl"
    "cs cs cs cs"
    "cs cs cs cs"
    "cs cs cs cs"
    "cs cs cs cs"
    "cp cp cp cp"
    "cp cp cp cp"
    "cp cp cp cp"
    "cp cp cp cp"
    "cu cu cu cu";
  background: #160b16;
}
}
</style>
