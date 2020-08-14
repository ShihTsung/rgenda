import Vue from 'vue';
import AddLicense from 'components/accounts/AddLicense.vue';
import HttpClient from 'common/http';
Vue.use(HttpClient);

new Vue({
  el: '#app',
  components: {
    AddLicense,
  },
});
