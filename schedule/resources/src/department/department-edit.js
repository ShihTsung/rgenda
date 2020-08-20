import Vue from 'vue';
import DepartmentEdit from 'components/department/DepartmentEdit.vue';
import HttpClient from 'common/http';
Vue.use(HttpClient);

new Vue({
  el: '#app',
  components: {
    DepartmentEdit,
  },
});
