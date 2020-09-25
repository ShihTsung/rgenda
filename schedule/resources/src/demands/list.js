import Vue from 'vue';
import DemandList from 'components/demands/List.vue';
import HttpClient from 'common/http';
Vue.use(HttpClient);

import {
  USER_TYPE,
} from '../accounts/constants.js'
Vue.use(USER_TYPE);
import {
  DEMAND_USER_LEVEL,
} from './constants.js'
Vue.use(DEMAND_USER_LEVEL);

new Vue({
  el: '#app',
  components: {
    'demand-list': DemandList,
  },
});
