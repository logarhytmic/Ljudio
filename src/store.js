import { createStore } from "vuex";

const state = {
  results: [],
  loggedIn: false,
};

const getters = {
  isLoggedIn: (state) => state.loggedIn,
};

const mutations = {
  addResults(state, results) {
    this.state.results = results;
  },
  checkLoggedIn(state) {
    this.state.loggedIn = !this.state.loggedIn;
  },
};


//AUTH
// const actions = {
//   async 
// }

export default createStore({ state, getters, mutations });
