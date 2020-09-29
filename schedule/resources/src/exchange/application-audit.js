import Vue from 'vue';
import ApplicationAudit from 'components/exchange/ApplicationAudit.vue';
import VueGoodTablePlugin from 'vue-good-table';
Vue.use(VueGoodTablePlugin);
import 'vue-good-table/dist/vue-good-table.css';
import HttpClient from 'common/http';
Vue.use(HttpClient);
import { APPLICATION_STATUS_CONST } from './constants.js';
Vue.use(APPLICATION_STATUS_CONST);

new Vue({
  el: '#app',
  components: {
    ApplicationAudit,
  },
});
