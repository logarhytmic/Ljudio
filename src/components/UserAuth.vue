<template>
  <div id="container-auth">
    <span class="components-auth">
      <LoginModal />
    </span>
    <span class="components-auth">
      <Logout />
    </span>
    <span class="components-auth">
      <RegisterModal />
    </span>
  </div>
</template>

<script>
import LoginModal from "./Login.vue";
import RegisterModal from "./Register.vue";
import Logout from "./Logout.vue";

export default {
  name: "UserAuth",
  components: {
    LoginModal,
    RegisterModal,
    Logout,
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
@import url("https://fonts.googleapis.com/css?family=Roboto+Condensed");

#container-auth {
  display: flex;
  justify-content: flex-end;
  /* margin: 10px; */
}

.components-auth {
  display: flex;
  padding: 0;
}
</style>
