<template>
  <div class="button_base b12_3d_glitch">
    <div></div>
    <div @click.prevent="Logout()">Logout</div>
  </div>
</template>

<script>
export default {
  name: "Logout",
  methods: {
    Logout() {
      fetch("/api/login", {
        method: "GET",
      })
        .then((r) => r.json())
        .then((d) => {
          if (d.loggedIn == true) {
            fetch("/api/login", {
              method: "DELETE",
            })
              .then((r) => r.json())
              .then((d) => {
                console.log("Success:", d);
                this.$store.commit("checkLoggedIn");
                this.$router.push("/");
              })
              .catch((e) => {
                console.error("Error:", e);
              });
          }
        })
        .catch((e) => {
          console.error("Error", e);
        });
    },
  },
};
</script>

<style scoped>
.preserve-3d {
  transform-style: preserve-3d;
  -webkit-transform-style: preserve-3d;
}

.button_base {
  margin: 0;
  border: 0;
  font-size: 18px;
  position: relative;
  /* top: 50%; */
  /* left: 50%; */
  /* margin-top: -25px; */
  /* margin-left: -100px; */
  width: 80px;
  height: 30px;
  text-align: center;
  box-sizing: border-box;
  -webkit-box-sizing: border-box;
  -moz-box-sizing: border-box;
  -webkit-user-select: none;
  cursor: default;
}

.button_base:hover {
  cursor: pointer;
}

/* ### ### ### 12 */
.b12_3d_glitch {
  border: 1px solid black;
  overflow: hidden;
  width: 80px;
  height: 31px;
}

.b12_3d_glitch div {
  padding: 0px;
  position: absolute;
  text-align: center;
  box-sizing: border-box;
  -webkit-box-sizing: border-box;
  -moz-box-sizing: border-box;
  width: 80px;
  height: 30px;
}

.b12_3d_glitch div:nth-child(1) {
  background-color: #3b203b;
  /* top: 0px;
  left: 0px; */
  border: #000000 solid 1px;
}

.b12_3d_glitch div:nth-child(2) {
  color: #ffffff;
  /* left: -100px; */
  top: 2px;
  /* width: 200px; */
  height: 50px;
}

.b12_3d_glitch:hover div:nth-child(1) {
  animation: b12_3d_glitch_bg 0.3s linear;
  -webkit-animation: b12_3d_glitch_bg 0.3s linear;
  -moz-animation: b12_3d_glitch_bg 0.3s linear;
  animation-fill-mode: forwards;
  -webkit-animation-fill-mode: forwards;
  -moz-animation-fill-mode: forwards;
}

.b12_3d_glitch:hover div:nth-child(2) {
  color: #000000;
  animation: b12_3d_glitch 0.3s linear;
  -webkit-animation: b12_3d_glitch 0.3s linear;
  -moz-animation: b12_3d_glitch 0.3s linear;
  animation-fill-mode: forwards;
  -webkit-animation-fill-mode: forwards;
  -moz-animation-fill-mode: forwards;
  background: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAUAAAAGCAYAAAAL+1RLAAAAF0lEQVQIW2NkwAIYgWKS6OIgQQxAoUoAE4AAUnD/0ugAAAAASUVORK5CYII=)
    repeat;
}

@-webkit-keyframes b12_3d_glitch_bg {
  49.00% {
    background-color: #3b203b;
  }
  50.00% {
    background-color: #000000;
  }
  to {
    background-color: #000000;
  }
}

@-webkit-keyframes b12_3d_glitch {
  from {
    transform: skewX(0deg);
    -webkit-transform: skewX(0deg);
    -moz-transform: skewX(0deg);
    color: #000000;
  }
  25.00% {
    transform: skewX(80deg);
    -webkit-transform: skewX(80deg);
    -moz-transform: skewX(80deg);
    color: #000000;
  }
  75.00% {
    transform: skewX(-20deg);
    -webkit-transform: skewX(-20deg);
    -moz-transform: skewX(-20deg);
    color: #ffffff;
  }
  90.00% {
    transform: skewX(0deg);
    -webkit-transform: skewX(0deg);
    -moz-transform: skewX(0deg);
    color: #ffffff;
  }
  to {
    transform: skewX(0deg);
    -webkit-transform: skewX(0deg);
    -moz-transform: skewX(0deg);
    color: #ffffff;
  }
}

@-moz-keyframes b12_3d_glitch_bg {
  49.00% {
    background-color: #3b203b;
  }
  50.00% {
    background-color: #000000;
  }
  to {
    background-color: #000000;
  }
}

@-moz-keyframes b12_3d_glitch {
  from {
    transform: skewX(0deg);
    -webkit-transform: skewX(0deg);
    -moz-transform: skewX(0deg);
    color: #000000;
  }
  25.00% {
    transform: skewX(80deg);
    -webkit-transform: skewX(80deg);
    -moz-transform: skewX(80deg);
    color: #000000;
  }
  75.00% {
    transform: skewX(-20deg);
    -webkit-transform: skewX(-20deg);
    -moz-transform: skewX(-20deg);
    color: #ffffff;
  }
  90.00% {
    transform: skewX(0deg);
    -webkit-transform: skewX(0deg);
    -moz-transform: skewX(0deg);
    color: #ffffff;
  }
  to {
    transform: skewX(0deg);
    -webkit-transform: skewX(0deg);
    -moz-transform: skewX(0deg);
    color: #ffffff;
  }
}
</style>
