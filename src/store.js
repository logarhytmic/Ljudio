import { createStore } from 'vuex';

const state = {
    results: []
}

const mutations = {
    addResults(state, results) {
        this.state.results = results;
    }
}

export default createStore({ state, mutations });