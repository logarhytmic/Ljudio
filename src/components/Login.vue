<template>
  <vue-final-modal
    v-model="showModal"
    classes="modal-container"
    content-class="modal-content"
  >
    <span class="modal__title"></span>
    <form @submit.prevent="">
      <div class="modal__content">
        <label ref="modalLabel" id="modal-p"></label>
        <div class="container-input">
          <div class="user-box">
            <input
              v-model="_data.email"
              type="email"
              name="input-email"
              alt="input-email"
              required
            />
            <label>Email</label>
          </div>
          <div class="user-box">
            <input
              v-model="_data.password"
              type="password"
              name="input-secret"
              alt="input-secret"
              required
            />
            <label>Password</label>
          </div>
        </div>
      </div>
      <div class="modal__action">
        <div class="button_base b12_3d_glitch">
          <div></div>
          <div @click.prevent="Login()">Sign in</div>
        </div>
        <div class="button_base b12_3d_glitch">
          <div></div>
          <div @click.prevent="CloseModal()">Cancel</div>
        </div>
      </div>
    </form>
  </vue-final-modal>
  <div class="button_base b12_3d_glitch">
    <div></div>
    <div @click.prevent="showModal = true">Login</div>
  </div>
</template>

<script>
export default {
  name: "LoginModal",
  data() {
    return {
      showModal: false,
      _data: {
        email: "",
        password: "",
      },
    };
  },
  methods: {
    CloseModal() {
      this.showModal = false;
      this._data.email = "";
      this._data.password = "";
    },
    Login() {
      if (
        this._data.email.trim().length > 0 &&
        this._data.password.trim().length > 0
      ) {
        let loginData = {
          email: this._data.email,
          password: this._data.password,
        };

        fetch("/api/login", {
          method: "POST",
          body: JSON.stringify(loginData),
          cache: "no-cache",
          headers: {
            "Content-Type": "application/json",
          },
        })
          .then((r) => r.json())
          .then((d) => {
            if (d.loggedIn === true) {
              console.log("Success:", d);
              this.showModal = false;
              this._data.email = "";
              this._data.password = "";
              this.$refs.modalLabel.innerText = "";
              localStorage.setItem("loggedIn", "true");

              this.$store.commit("checkLoggedIn");
              this.$router.push("/app");
            } else {
              console.log("Unsuccessful:", d);
              this._data.password = "";
              this.$refs.modalLabel.innerText = "No such email or password!";
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

.container-input {
  margin-top: 10px;
}

label {
  color: white;
}

/* ==== Validation CSS ==== */

input:required {
  box-shadow: none;
}

/* ==== Modal CSS ==== */

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
  border: 1px solid coral;
  border-radius: 0.25rem;
  background: #231123;
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
  /* padding: 1rem 0 0; */
}

.modal__close {
  position: absolute;
  top: 0.5rem;
  right: 0.5rem;
}

/* ==== Input CSS ==== */

.user-box {
  position: relative;
}

.user-box input {
  width: 100%;
  padding: 10px 0;
  font-size: 16px;
  color: #fff;
  margin-bottom: 30px;
  border: none;
  border-bottom: 1px solid #fff;
  outline: none;
  background: transparent;
}
.user-box label {
  position: absolute;
  top: 0;
  left: 0;
  padding: 10px 0;
  font-size: 16px;
  color: rgb(143, 143, 143);
  pointer-events: none;
  transition: 0.5s;
}

.user-box input:focus ~ label,
.user-box input:valid ~ label {
  top: -20px;
  left: 0;
  color: coral;
  font-size: 12px;
}

.user-box input:focus,
.user-box input:valid {
  border-bottom: 1px solid coral;
}

/* ==== Button CSS ==== */

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
