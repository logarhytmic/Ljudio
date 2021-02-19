import { createApp } from 'vue';
import App from './App.vue';
import './index.css';
import VueFinalModal from 'vue-final-modal';
import Router from './router.js'
import Store from './store.js';

const app = createApp(App);
app.use(VueFinalModal());
app.use(Router);
app.use(Store);
app.mount('#app');