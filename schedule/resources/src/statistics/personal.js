import Vue from 'vue';
import Personal from 'components/statistics/Personal.vue';
import HttpClient from 'common/http';
Vue.use(HttpClient);
import VueGoodTablePlugin from 'vue-good-table';
Vue.use(VueGoodTablePlugin);
import 'vue-good-table/dist/vue-good-table.css';
import { SHIFT_TYPE } from '../shifts/constants.js';
Vue.use(SHIFT_TYPE);
import { PROMISE_LEAVE_ITEM } from '../promise-leave/constants.js';
Vue.use(PROMISE_LEAVE_ITEM);
import { TIME_ADJUSTMENT_ITEM } from '../time-adjustment/constants.js';
Vue.use(TIME_ADJUSTMENT_ITEM);
import { USER_TYPE } from '../accounts/constants.js'
Vue.use(USER_TYPE);

new Vue({
  el: '#app',
  components: {
    Personal,
  },
});
