import Vue from 'vue';
import AccountList from 'components/accounts/list.vue';

new Vue({
  el: '#app',
  components: {
    'account-list': AccountList,
  },
});
