import { createApp } from 'vue';
import App from './App.vue';
import './index.css';
import Store from './store.js';
import VueFinalModal from 'vue-final-modal';

const app = createApp(App);
app.use(Store);
app.use(VueFinalModal());
app.mount('#app');