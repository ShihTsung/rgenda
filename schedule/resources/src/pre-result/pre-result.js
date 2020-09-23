import Vue from 'vue';
import PreResult from 'components/pre-result/PreResult.vue';
import HttpClient from 'common/http';
Vue.use(HttpClient);
import { SHIFT_TYPE } from '../shifts/constants.js';
Vue.use(SHIFT_TYPE);
import { TIME_ADJUSTMENT_ITEM } from '../time-adjustment/constants.js';
Vue.use(TIME_ADJUSTMENT_ITEM);
import { PROMISE_LEAVE_CATEGORY, PROMISE_LEAVE_ITEM } from '../promise-leave/constants.js';
Vue.use(PROMISE_LEAVE_CATEGORY);
Vue.use(PROMISE_LEAVE_ITEM);

new Vue({
  el: '#app',
  components: {
    PreResult,
  },
});
