<template>
  <header id="header">
      <h1>Spela Shoreline</h1>
    <div id="user-auth">
      <UserAuth />
    </div>
  </header>
</template>

<script>
import UserAuth from "./UserAuth.vue";

export default {
  name: "Header",
  components: {
    UserAuth,
  },
};
</script>

<style scoped>
#header {
  display: grid;
  grid-template-columns: 50% 50%;
  grid-template-rows: auto;
  background: #231123;
  color: #fff;
  text-align: center;
  border: 1px solid black;
  height: 100%;
}

</style>
