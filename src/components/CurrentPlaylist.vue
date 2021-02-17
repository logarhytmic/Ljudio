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
