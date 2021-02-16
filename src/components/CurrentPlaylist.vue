<template>
    <div id="current-playlist">
        <p>current playlist</p>
        <span
            v-for="song in get_songs"
            :key="song.id"
            class="song-item">
                <p>{{ song.title }}</p>
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
                originator: "",
                duration: "",
            },
        };
    },
    mounted() {
        this.fetch_songs("/api/current-playlist/1");
    },
    computed: {
        get_songs() {
            return this.$store.state.songs;
        }
    },
    methods: {
        async fetch_songs(url) {
            const res = await fetch(url, {
                method: "GET",
                headers: {
                    "Content-Type": "application/json"
                },
            });
            this.$store.commit("addCurrentPlaylist", await res.json());
        },
    }
};
</script>

<style scoped>
    .current-playlist {
        display: flex;
        flex-flow: column row;
    }
</style>
