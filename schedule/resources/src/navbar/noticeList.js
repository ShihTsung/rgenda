import Vue from 'vue';
import NoticeList from 'components/navbar/noticeList.vue';
import HttpClient from 'common/http';
Vue.use(HttpClient);

new Vue({
  el: '#navbar',
  components: {
    'notice-list': NoticeList,
  },
});
