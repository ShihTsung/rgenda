import Vue from 'vue';
import AccountList from 'components/accounts/List.vue';
import HttpClient from 'common/http';
Vue.use(HttpClient);
import {
  USER_TYPE,
} from '../accounts/constants.js'
Vue.use(USER_TYPE);

new Vue({
  el: '#app',
  components: {
    'account-list': AccountList,
  },
});
