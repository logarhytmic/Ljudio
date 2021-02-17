<template>
 <link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
  />

    <div id="playlists">
        <p>Playlists</p>
         <div> <button id="button-add">
        <em class="fa fa-plus"></em>
      </button> </div>
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

#playlists {
  display: grid;
  grid-template-columns: 1fr 1fr;
  grid-template-rows: auto;
  padding-top: 10px;
}

p {
  color:white;
}

button {
  border: 1px solid #3b203b;
  background-color: #3b203b;
  color: white;
  padding: 5px;
  padding-top: 6px;
  padding-left: 10px;
  padding-right: 10px;
  cursor: pointer;
}

</style>