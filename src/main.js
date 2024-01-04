import Vue from 'vue';
import App from './App.vue';
import VueBootstrap from 'bootstrap-vue'
import VueInsProgressBar from 'vue-ins-progress-bar'
import VueCustomScrollbar from 'vue-custom-scrollbar'
import VuePanel from './plugins/panel/'

import { router } from './router';
import store from './store';
import 'bootstrap';
import 'bootstrap-vue/dist/bootstrap-vue.css'

import VeeValidate from 'vee-validate';
import Vuex from 'vuex';
import Swal from 'sweetalert2'
import { library } from '@fortawesome/fontawesome-svg-core';
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';
import 'devextreme/dist/css/dx.common.css';
import 'devextreme/dist/css/dx.light.compact.css';
import LocalStorageService from './LocalStorageService';
import './scss/vue.scss';
import './assets/all.css';
import 'vue-custom-scrollbar/dist/vueScrollbar.css'
require('dotenv').config()

window.LocalStorageService = LocalStorageService
require('./interceptor');
window.Swal = Swal
const Toast = Swal.mixin({
  toast: true,
  position: 'top-end',
  showConfirmButton: false,
  timer: 3000,
  timerProgressBar: true,
  didOpen: (toast) => {
    toast.addEventListener('mouseenter', Swal.stopTimer)
    toast.addEventListener('mouseleave', Swal.resumeTimer)
  }
})
window.Toast = Toast
import {
  faHome,
  faUser,
  faUserPlus,
  faSignInAlt,
  faSignOutAlt
} from '@fortawesome/free-solid-svg-icons';

library.add(faHome, faUser, faUserPlus, faSignInAlt, faSignOutAlt);

Vue.config.productionTip = false;

Vue.use(VeeValidate);
Vue.use(VueBootstrap);
Vue.component('font-awesome-icon', FontAwesomeIcon);
Vue.component('vue-custom-scrollbar', VueCustomScrollbar)
Vue.use(VuePanel)
Vue.use(Vuex);
Vue.use(VueInsProgressBar, {
  position: 'fixed',
  show: true,
  height: '3px'
})

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app');
