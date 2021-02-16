import { createRouter, createWebHistory } from "vue-router";
import store from './store.js'
import AppContent from "./views/AppContent.vue";
import Home from './views/Home.vue'

const routes = [
  {
    path: "/app",
    name: "AppContent",
    component: AppContent,
    beforeEnter(to, from, next) {
      if (store.getters.isLoggedIn) {
        next();
      } else {
        next('/index');
      }
    }
  },
  {
    path: "/",
    name: "Home",
    component: Home,
    alias: ["/index", "/home"],
    // This isnt working.
    // Expected result: If you're logged in and you try to enter the 3 endpoints; "/", "/home" or "/index" then you will be redirected to "/app"
    // Actual result: It'll NOT take you to the "/app" endpoint. Instead it allows you to enter the root endpoint
    // beforeEnter(to, from, next) {
    //   if (store.getters.isLoggedIn) {
    //     next('/app');
    //   } else {
    //     next();
    //   }
    // }
  }
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;