<template>
    <div id="playlists">
        <p>playlists</p>
        <span 
            v-for="playlist in get_playlist"
            :key="playlist.id"
            class="playlist-item">
                <p>{{ playlist.title }}</p>
        </span>
    </div>
</template>

<script>
export default {
    // make a span for playlist items, v-for spans into the div, each span containing one playlist item
    data() {
        return {
            // TODO add number of songs
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
    }
}
</script>

<style scoped>
    .playlists {
        display: flex;
        flex-flow: column row;
    }
</style>