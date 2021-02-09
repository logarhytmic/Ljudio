<template>
  <div id="container-auth">
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
      <button @click.prevent="Login()" id="btn-login">Login</button>
      <button @click.prevent="Register()" id="btn-register">Register</button>
      <button @click.prevent="Logout()" id="btn-logout">Logout</button>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      _data: {
        first_name: "",
        last_name: "",
        email: "",
        password: "",
      },
    };
  },
  methods: {
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
</style>
