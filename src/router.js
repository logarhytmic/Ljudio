import { createRouter, createWebHistory } from "vue-router";
import store from './store.js'
import Container from "./components/Container.vue";
import Home from './components/Home.vue'

const routes = [
    {
        path: "/container",
        name: "Container",
        component: Container,
        beforeEnter(to, from, next) {
          if (store.getters.isLoggedIn) {
            next();
          } else {
            next('/');
          }
        }
    },
    {
        path: "/",
        name: "Home",
        component: Home
    }
];

const router = createRouter({
    history: createWebHistory(),
    routes,
  });
  
  export default router;