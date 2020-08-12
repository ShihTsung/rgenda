import Vue from 'vue';
import AccountList from 'components/accounts/List.vue';
import HttpClient from 'common/http';
Vue.use(HttpClient);

new Vue({
  el: '#app',
  components: {
    'account-list': AccountList,
  },
});
