<template>
    <div id="playlists">
        <p>playlists</p>
        <span 
            v-for="playlist in get_playlist"
            :key="playlist.id"
            class="playlist-item">
                {{ playlist.title }}
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
        console.log(this.$store.state.playlists);
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
            await this.$store.commit("addPlaylists", res.json());
        },
        show_playlists() {
            let playlist = this.fetch_playlists("/api/playlists");
        }
    }
}
</script>

<style scoped>
    .playlists {
        display: flex;
        flex-flow: column row;
    }
</style>