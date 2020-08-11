import Vue from 'vue';
import NoticeList from 'components/navbar/NoticeList.vue';
import HttpClient from 'common/http';
Vue.use(HttpClient);

new Vue({
  el: '#navbar',
  components: {
    NoticeList,
  },
});
