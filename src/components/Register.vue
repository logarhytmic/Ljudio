<template>
  <vue-final-modal
    v-model="showModal"
    classes="modal-container"
    content-class="modal-content"
  >
    <span class="modal__title">Login</span>
    <form @submit.prevent="">
      <div class="modal__content">
        <label ref="modalLabel" id="modal-p"></label>
        <input
          v-model="_data.first_name"
          type="text"
          id="input-forename"
          name="input-forename"
          alt="input-forename"
          placeholder="Forename..."
        />
        <input
          v-model="_data.last_name"
          type="text"
          id="input-surname"
          name="input-surname"
          alt="input-surname"
          placeholder="Surname..."
        />
        <input
          v-model="_data.email"
          type="text"
          id="input-email"
          name="input-email"
          alt="input-email"
          placeholder="Email..."
        />
        <input
          v-model="_data.password"
          type="password"
          id="input-secret"
          name="input-secret"
          alt="input-secret"
          placeholder="Password..."
        />
      </div>
      <div class="modal__action">
        <button class="vfm-btn" @click="Register()">confirm</button>
        <button class="vfm-btn" @click="CloseModal()">cancel</button>
      </div>
    </form>
  </vue-final-modal>
  <div class="button_base b12_3d_glitch">
    <div></div>
    <div @click.prevent="showModal = true">Register</div>
  </div>
  <!-- <button class="vfm-btn" @click="showModal = true">Register</button> -->
</template>

<script>
export default {
  name: "RegisterModal",
  data() {
    return {
      showModal: false,
      _data: {
        first_name: "",
        last_name: "",
        email: "",
        password: "",
      },
    };
  },
  methods: {
    CloseModal() {
      this.showModal = false;
      this._data.first_name = "";
      this._data.last_name = "";
      this._data.email = "";
      this._data.password = "";
    },
    Register() {
      if (
        this._data.first_name.trim().length > 0 &&
        this._data.last_name.trim().length > 0 &&
        this._data.email.trim().length > 0 &&
        this._data.password.trim().length > 0
      ) {
        fetch("/api/users", {
          method: "POST",
          body: JSON.stringify(this._data),
          cache: "no-cache",
          headers: {
            "Content-Type": "application/json",
          },
        })
          .then((r) => r.json())
          .then((d) => {
            if (d.affectedRows === 1) {
              console.log("Success:", d);
              this.showModal = false;
              this._data.first_name = "";
              this._data.last_name = "";
              this._data.email = "";
              this._data.password = "";
            } else {
              console.log("Unsuccessful:", d);
              this.$refs.modalLabel.innerText = "Something went wrong! :(";
              this._data.password = "";
            }
          })
          .catch((e) => {
            console.error("Error:", e);
          });
      }
    },
  },
};
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css?family=Roboto+Condensed");

:deep(.modal-container) {
  display: flex;
  justify-content: center;
  align-items: center;
}

:deep(.modal-content) {
  position: relative;
  display: flex;
  flex-direction: column;
  max-height: 90%;
  margin: 0 1rem;
  padding: 1rem;
  border: 1px solid #e2e8f0;
  border-radius: 0.25rem;
  background: #fff;
}

.modal__title {
  margin: 0 2rem 0 0;
  font-size: 1.5rem;
  font-weight: 700;
}

.modal__content {
  flex-grow: 1;
  overflow-y: auto;
  color: black;
}

.modal__action {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-shrink: 0;
  padding: 1rem 0 0;
}

.modal__close {
  position: absolute;
  top: 0.5rem;
  right: 0.5rem;
}

.preserve-3d {
  transform-style: preserve-3d;
  -webkit-transform-style: preserve-3d;
}

.button_base {
  margin: 0;
  border: 0;
  font-size: 18px;
  position: relative;
  /* top: 50%;
  left: 50%;
  margin-top: -25px;
  margin-left: -100px; */
  width: 100px;
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
  width: 100px;
  height: 31px;
}

.b12_3d_glitch div {
  padding: 0px;
  position: absolute;
  text-align: center;
  box-sizing: border-box;
  -webkit-box-sizing: border-box;
  -moz-box-sizing: border-box;
  width: 100px;
  height: 30px;
}

.b12_3d_glitch div:nth-child(1) {
  background-color: #3b203b;
  /* top: 0px;
  left: 0px; */
  border: #000000 solid 1px;
}

.b12_3d_glitch div:nth-child(2) {
  color: #FFFFFF;
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
    color: #FFFFFF;
  }
  90.00% {
    transform: skewX(0deg);
    -webkit-transform: skewX(0deg);
    -moz-transform: skewX(0deg);
    color: #FFFFFF;
  }
  to {
    transform: skewX(0deg);
    -webkit-transform: skewX(0deg);
    -moz-transform: skewX(0deg);
    color: #FFFFFF;
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
