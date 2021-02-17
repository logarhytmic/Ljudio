<template>
    <div id="playlists">
        <p>playlists</p>
        <span
            v-bind:key="playlist.id"
            v-for="playlist in get_playlist"
            class="playlist-item">
                <div @click="fetch_songs('/api/current-playlist/' + playlist.id)">
                    {{ playlist.title }}
                </div>
        </span>
    </div>
</template>

<script>

export default {
    data() {
        return {
            _data: {
                id: "",
                title: "",
                user_id: "",
            },
        };
    },
    mounted() {
        this.fetch_playlists("/api/playlists");
    },
    computed: {
        get_playlist() {
            return this.$store.state.playlists;
        }
    },
    methods: {
        async fetch_playlists(url) {
            const res = await fetch(url, {
                method: "GET",
                headers: {
                    "Content-Type": "application/json"
                },
            });
            this.$store.commit("addPlaylists", await res.json());
        },
        async fetch_songs(url) {
            const res = await fetch(url, {
                method: "GET",
                headers: {
                    "Content-Type": "application/json"
                },
            });
            this.$store.commit("addCurrentPlaylist", await res.json());
            console.log(this.$store.state.songs);
        },
    }
};
</script>

<style scoped>
    .playlists {
        display: flex;
        flex-flow: column row;
    }
</style>