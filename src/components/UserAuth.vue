<template>
  <div id="container-auth">
    <LoginModal /><br>
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
    <div id="btns-auth">
      <button @click.prevent="Login()" id="btn-open-login-modal">Login</button>
      <button @click.prevent="Register()" id="btn-register">Register</button>
      <button @click.prevent="Logout()" id="btn-logout">Logout</button>
    </div>
  </div>
</template>

<script>
import LoginModal from "./Login.vue";

export default {
  components: {
    LoginModal,
  },
  data() {
    return {
      showLoginModal: false,
      showRegisterModal: false,
      _data: {
        first_name: "",
        last_name: "",
        email: "",
        password: "",
      },
    };
  },
  methods: {
    CloseLoginModal() {
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
            console.log("Success:", d);
          })
          .catch((e) => {
            console.error("Error:", e);
          });
      }
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
            console.log("Success:", d);
          })
          .catch((e) => {
            console.error("Error:", e);
          });
      }
    },

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
#container-auth {
  display: grid;
  grid-template-columns: auto;
  grid-template-rows: auto;
  justify-content: space-evenly;
}

input {
  padding: 5px;
  border: none;
  border-bottom: 1px solid #ccc;
}

button {
  margin-top: 8px;
  margin-right: 2px;
}

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
