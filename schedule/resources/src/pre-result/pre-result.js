import Vue from 'vue';
import PreResult from 'components/pre-result/PreResult.vue';
import HttpClient from 'common/http';
Vue.use(HttpClient);

new Vue({
  el: '#app',
  components: {
    PreResult,
  },
});
