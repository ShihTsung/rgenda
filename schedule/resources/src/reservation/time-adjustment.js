import Vue from 'vue';
import TimeAdjustment from 'components/reservation/TimeAdjustment.vue';
import HttpClient from 'common/http';
Vue.use(HttpClient);

import {
  TIME_ADJUSTMENT_TYPE,
  TIME_ADJUSTMENT_ITEM,
} from './constants.js'
Vue.use(TIME_ADJUSTMENT_TYPE);
Vue.use(TIME_ADJUSTMENT_ITEM);

new Vue({
  el: '#app',
  components: {
    TimeAdjustment,
  },
});
