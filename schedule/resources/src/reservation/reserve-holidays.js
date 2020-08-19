import Vue from 'vue';
import ReserveHolidays from 'components/reservation/ReserveHolidays.vue';
import HttpClient from 'common/http';
Vue.use(HttpClient);

import {
  ADJUSTMENT_TYPE,
  ADJUSTMENT_ITEM,
} from './constants.js'
Vue.use(ADJUSTMENT_TYPE);
Vue.use(ADJUSTMENT_ITEM);

new Vue({
  el: '#app',
  components: {
    ReserveHolidays,
  },
});
