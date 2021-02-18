import { createStore } from "vuex";

const state = {
  results: [],
  playlists: [],
  songs: [],
  //loggedIn: !!false || JSON.parse(localStorage.getItem("loggedIn")),
  currentSong: {},
  currentPlaylist: {

  },
}

const getters = {
  isLoggedIn: (state) => state.loggedIn,
}

const mutations = {
  addResults(state, results) {
    state.results = results;
  },

  setCurrentSong(state, song) {
    state.currentSong = song;
  },
  addPlaylists(state, playlists) {
    state.playlists = playlists;
  },

  addCurrentPlaylist(state, songs) {
    state.songs = songs;
  },

  setCurrentPlaylist(state, playlist) {
    state.currentPlaylist = playlist;
  },

  removeSongFromQueue(state, song) {
    // Mutations are void functions. They can not return anything. TODO: Convert this to an action with promise
    let index = state.queue.findIndex((e) => Object.toJson(e) == Object.toJson(song));

    if (index != -1) {
      state.queue = state.queue.splice(index, 1);

      return 1;
    }

    return 0;
  },

  checkLoggedIn(state) {
    state.loggedIn = !state.loggedIn;
  },

  clearStore(state) {
    state.results = [];
    state.playlists = [];
    state.songs = [];
    state.queue = [];
    state.currentSong = {};
  }
}

export default createStore({ state, getters, mutations });
