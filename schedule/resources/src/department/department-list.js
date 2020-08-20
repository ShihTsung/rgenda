import Vue from 'vue';
import DepartmentList from 'components/department/DepartmentList.vue';
import VueGoodTablePlugin from 'vue-good-table';
Vue.use(VueGoodTablePlugin);
import 'vue-good-table/dist/vue-good-table.css';
import HttpClient from 'common/http';
Vue.use(HttpClient);
import { DEPARTMENT_CONST } from './constants.js';
Vue.use(DEPARTMENT_CONST);

new Vue({
  el: '#app',
  components: {
    DepartmentList,
  },
});
