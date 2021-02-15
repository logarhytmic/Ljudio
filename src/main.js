import { createApp } from 'vue';
import App from './App.vue';
import './index.css';
import Store from './store.js';
import VueFinalModal from 'vue-final-modal';
import VueYoutube from 'vue-youtube';

const app = createApp(App);
app.use(Store);
app.use(VueFinalModal());
app.use(VueYoutube);
app.mount('#app');