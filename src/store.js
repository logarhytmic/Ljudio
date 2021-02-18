import { createStore } from "vuex";

const state = {

  results: [],
  playlists: [],
  songs: [],
  queue: [],
  loggedIn: !!false || JSON.parse(localStorage.getItem("loggedIn")),
  currentSong: {},
}

const getters = {
  isLoggedIn: (state) => state.loggedIn,
}

const mutations = {
  addResults(state, results) {
    state.results = results;
  },

  addSongToQueue(state, song) {
    state.queue.push(song);
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
