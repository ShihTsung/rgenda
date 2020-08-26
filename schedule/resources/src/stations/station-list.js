import Vue from 'vue';
import StationList from 'components/stations/List.vue';
import HttpClient from 'common/http';
Vue.use(HttpClient);

new Vue({
  el: '#app',
  components: {
    StationList,
  },
});
