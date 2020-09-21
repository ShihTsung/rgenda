import Vue from 'vue';
import Results from 'components/results/Results.vue';
import HttpClient from 'common/http';
Vue.use(HttpClient);
import { SHIFT_TYPE } from '../shifts/constants.js';
Vue.use(SHIFT_TYPE);
import { TIME_ADJUSTMENT_ITEM } from '../time-adjustment/constants.js';
Vue.use(TIME_ADJUSTMENT_ITEM);

new Vue({
  el: '#app',
  components: {
    Results,
  },
});
