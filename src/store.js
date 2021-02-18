import { createStore } from "vuex";

const state = {
  results: [],
  playlists: [],
  songs: [],
  loggedIn: !!false || JSON.parse(localStorage.getItem("loggedIn")),
  currentSong: {},
  currentPlaylist: {},
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
