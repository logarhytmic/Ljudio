import { createStore } from 'vuex';

const state = {
    results: [],
    playlists: [],
    songs: [],
}

const mutations = {
    addResults(state, results) {
        this.state.results = results;
    },
    addPlaylists(state, playlists) {
        this.state.playlists = playlists;
    },
    addCurrentPlaylist(state, songs) {
        this.state.songs = songs;
    }
}

export default createStore({ state, mutations });