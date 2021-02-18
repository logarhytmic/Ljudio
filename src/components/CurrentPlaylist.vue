<template>
 <link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
  />
    <div id="current-playlist">
        <p>Current Playlist</p>
         <div> <button id="button-add">
        <em class="fa fa-plus"></em>
      </button> </div>
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
    computed: {
        get_songs() {
            return this.$store.state.songs;
        }
    },
    methods: {
        async on_click(element) {
            // TODO when current song ends, set next one in songs[] to current
            // TODO how to make page react to slider reaching maximum
            // for (let i = this.get_songs().indexOf(element); i < this.get_songs().length; ++ i) {
            //     this.$store.commit("addSongToQueue", this.get_songs().indexOf(i));
            // }
            this.$store.commit("addSongToQueue", element);
            this.$store.commit("setCurrentSong", element);
        },
    }
};
</script>

<style scoped>

#current-playlist {
  display: grid;
  grid-template-columns: 1fr 1fr;
  grid-template-rows: auto;
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
