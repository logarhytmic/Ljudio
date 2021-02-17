import { createStore } from "vuex";

const state = {

  results: [],
  queue: [],
  loggedIn: !!false || JSON.parse(localStorage.getItem("loggedIn")),
  currentSong: {},
}

const getters = {
  isLoggedIn: (state) => state.loggedIn,
}

const mutations = {
  addResults(state, results) {
    this.state.results = results;
  },

  addSongToQueue(state, song) {
    this.state.queue.push(song);
  },

  setCurrentSong(state, song) {
    state.currentSong = song;
  },

  removeSongFromQueue(state, song) {
    // Mutations are void functions. They can not return anything. TODO: Convert this to an action with promise
    let index = this.state.queue.findIndex((e) => Object.toJson(e) == Object.toJson(song));

    if (index != -1) {
      this.state.queue = this.state.queue.splice(index, 1);

      return 1;
    }

    return 0;
  },

  checkLoggedIn(state) {
    this.state.loggedIn = !this.state.loggedIn;
  },
}

export default createStore({ state, getters, mutations });
