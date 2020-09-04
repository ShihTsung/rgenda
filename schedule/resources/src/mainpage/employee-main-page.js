import Vue from 'vue';
import EmployeeMainPage from 'components/mainpage/EmployeeMainPage.vue';
import HttpClient from 'common/http';
Vue.use(HttpClient);
import { SHIFT_TYPE } from '../shifts/constants.js';
Vue.use(SHIFT_TYPE);
import { PROMISE_LEAVE_ITEM } from '../promise-leave/constants.js';
Vue.use(PROMISE_LEAVE_ITEM);

new Vue({
  el: '#app',
  components: {
    EmployeeMainPage,
  },
});
