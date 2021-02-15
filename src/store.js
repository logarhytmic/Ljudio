import { createStore } from 'vuex';

const state = {
    results: [],
    queue: [],
}

const mutations = {
    addResults(state, results) {
        this.state.results = results;
    },

    addSongToQueue(state, song) {
        this.state.queue.push(song);
    },

    removeSongFromQueue(state, song) {
        // Mutations are void functions. They can not return anything. TODO: Convert this to an action with promise
        let index = this.state.queue.findIndex((e) => Object.toJson(e) == Object.toJson(song));

        if (index != -1) {
            this.state.queue = this.state.queue.splice(index, 1);

            return 1;
        }

        return 0;
    }
}

export default createStore({ state, mutations });