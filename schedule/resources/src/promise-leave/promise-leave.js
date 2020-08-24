import Vue from 'vue';
import PromiseLeave from 'components/promise-leave/PromiseLeave.vue';
import HttpClient from 'common/http';
Vue.use(HttpClient);

import {
  PROMISE_LEAVE_CATEGORY,
  PROMISE_LEAVE_ITEM,
} from './constants.js'
Vue.use(PROMISE_LEAVE_CATEGORY);
Vue.use(PROMISE_LEAVE_ITEM);

new Vue({
  el: '#app',
  components: {
    PromiseLeave,
  },
});
