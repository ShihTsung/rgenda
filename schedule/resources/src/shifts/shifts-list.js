import Vue from 'vue';
import ShiftsList from 'components/shifts/List.vue';
import HttpClient from 'common/http';
Vue.use(HttpClient);

new Vue({
  el: '#app',
  components: {
    ShiftsList,
  },
});
