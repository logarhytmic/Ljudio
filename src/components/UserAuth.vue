<template>
  <div id="container-auth">
    <LoginModal />
    <RegisterModal />
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
    return {
    };
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
#container-auth {
  display: grid;
  grid-template-columns: auto;
  grid-template-rows: auto;
  justify-content: space-evenly;
}
</style>
