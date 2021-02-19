<template>
  <div id="container-auth">
    <div id="buttons">
      <span v-if="!ifLoggedIn" class="components-auth">
        <LoginModal />
      </span>
      <span v-if="ifLoggedIn" class="components-auth">
        <Logout />
      </span>
      <span v-if="!ifLoggedIn" class="components-auth">
        <RegisterModal />
      </span>
    </div>
  </div>
</template>

<script>
import LoginModal from "./Login.vue";
import RegisterModal from "./Register.vue";
import Logout from "./Logout.vue";
import { mapGetters } from "vuex";

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
  computed: {
    ifLoggedIn() {
      return this.$store.state.loggedIn;
    },
    ...mapGetters(["isLoggedIn"]),
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
}

#buttons {
  display: flex;
  justify-content: flex-end;
}

.components-auth {
  display: flex;
}
</style>
