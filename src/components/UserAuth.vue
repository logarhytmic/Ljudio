<template>
  <div id="container-auth">
    <span class="components-auth">
      <LoginModal />
    </span>
    <span class="components-auth">
      <RegisterModal />
    </span>
    <span class="components-auth">
    <button @click.prevent="Logout()">Logout</button>
    </span>
  </div>
</template>

<script>
import LoginModal from "./Login.vue";
import RegisterModal from "./Register.vue";

export default {
  components: {
    LoginModal,
    RegisterModal,
  },
  data() {
    return {};
  },
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
.components-auth {
  margin: 2px;
}

</style>
