import { createStore } from 'vuex';

const state = {
    results: [],
    playlists: [],
}

const mutations = {
    addResults(state, results) {
        this.state.results = results;
    },
    addPlaylists(state, playlists) {
        this.state.playlists = playlists;
    },
    addCurrentPlaylist(state, playlist) {
        this.state.playlist = playlist;
    }
}

export default createStore({ state, mutations });