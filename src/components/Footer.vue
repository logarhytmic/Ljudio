<template>
  <footer class="footer">
    <div class="container">
      <p>
        &copy; Copyright 2021: Spela Shoreline<br /><br />
        <github-button href="https://github.com/HansenChristoffer/Ljudio"
          >Follow @Ljudio</github-button
        >
      </p>
    </div>
  </footer>
</template>

<script>
import GithubButton from "vue-github-button";
export default {
  components: {
    GithubButton,
  },
};
</script>

<style scoped>
.footer {
  display: grid;
  grid-template-columns: auto;
  grid-template-rows: auto;
  width: 100%;
  height: 100%;
  margin-left: none;
  background: #231123;
}
.container > p {
  font-family: Verdana, Geneva, Tahoma, sans-serif;
  color: white;
  text-align: center;
}
</style>
