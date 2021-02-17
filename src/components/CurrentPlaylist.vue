<template>
    <div id="current-playlist">
        <p>current playlist</p>
        <span
            v-for="song in get_songs"
            :key="song.id"
            class="song-item">
                <div @click="on_click(song)">{{ song.title }}</div>
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
                duration: 0,
            },
        };
    },
    // mounted() {
    //     this.fetch_songs("/api/current-playlist/1");
    // },
    computed: {
        get_songs() {
            return this.$store.state.songs;
        }
    },
    methods: {
        async on_click(element) {
            console.log(element);
            this.$store.commit("addSongToQueue", element);
            this.$store.commit("setCurrentSong", element);
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
