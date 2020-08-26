import Vue from 'vue';
import ShiftsList from 'components/shifts/List.vue';
import HttpClient from 'common/http';
Vue.use(HttpClient);
import {
  SHIFT_TYPE,
} from './constants.js'
Vue.use(SHIFT_TYPE);

new Vue({
  el: '#app',
  components: {
    ShiftsList,
  },
});
