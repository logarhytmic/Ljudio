<template>
  <vue-final-modal
    v-model="showLoginModal"
    classes="modal-container"
    content-class="modal-content"
  >
    <span class="modal__title">Login</span>
    <div class="modal__content">
      <label ref="modalLabel" id="modal-p"></label>
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
      <button class="vfm-btn" @click="Login()">confirm</button>
      <button class="vfm-btn" @click="CloseLoginModal()">cancel</button>
    </div>
  </vue-final-modal>
  <button class="vfm-btn" @click="showLoginModal = true">Login</button>
</template>

<script>
export default {
  data() {
    return {
      showLoginModal: false,
      _data: {
        email: "",
        password: "",
      },
    };
  },
  methods: {
    CloseLoginModal() {
      this.showLoginModal = false;
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
              this.showLoginModal = false;
              this._data.email = "";
              this._data.password = "";
              this.$refs.modalLabel.innerText = "";
            } else {
              console.log("Unsuccessful:", d);
              this._data.email = "";
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
</style>
