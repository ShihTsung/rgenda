import Vue from 'vue';
import TimeAdjustment from 'components/reservation/TimeAdjustment.vue';
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
    TimeAdjustment,
  },
});
