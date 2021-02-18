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
    alias: ['/', '/index', '/home'],
    beforeEnter(to, from, next) {
      if (store.getters.isLoggedIn) {
        next('/app');
      } else {
        next();
      }
    }
  }
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;