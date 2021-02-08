<template>
  <div id="container-auth">
        <input v-model="_forename" type="text" id="input-forename" name="input-forename" alt="input-forename" placeholder="Forename...">
        <input v-model="_surname" type="text" id="input-surname" name="input-surname" alt="input-surname" placeholder="Surname...">
        <input v-model="_email" type="text" id="input-email" name="input-email" alt="input-email" placeholder="Email...">
        <input v-model="_secret" type="password" id="input-secret" name="input-secret" alt="input-secret" placeholder="Password...">
      <div id="btns-auth">
        <button @click.prevent="Login()" id="btn-login">Login</button>
        <button @click.prevent="Register()" id="btn-register">Register</button>
      </div>
  </div>
</template>

<script>
export default {
    data() {
        return {
            _forename: "",
            _surname: "",
            _email: "",
            _secret: ""
        }
    }, methods: {
        Login() {
        },
        Register() {
        }
    }
}
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