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
    // mounted() {
    //     this.fetch_songs("/api/current-playlist/1");
    // },
    computed: {
        get_songs() {
            return this.$store.state.songs;
        }
    },
    methods: {
        
    }
};
</script>

<style scoped>
    .current-playlist {
        display: flex;
        flex-flow: column row;
    }
</style>
