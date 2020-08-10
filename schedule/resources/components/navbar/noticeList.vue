<template>
  <div class="dropdown" id="notification-list">
    <a class="nav-link dark" href="#" id="navbar-notice-list" role="button" data-toggle="dropdown"
      aria-haspopup="true" aria-expanded="false">
      <!-- <i class="fa fa-bell" aria-hidden="true"></i> -->
      <svg class="icon_color" xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24">
        <path
          d="M13 16h-2v-6h2v6zm-1-10.25c.69 0 1.25.56 1.25 1.25s-.56 1.25-1.25 1.25-1.25-.56-1.25-1.25.56-1.25 1.25-1.25zm0-2.75c5.514 0 10 3.592 10 8.007 0 4.917-5.145 7.961-9.91 7.961-1.937 0-3.383-.397-4.394-.644-1 .613-1.595 1.037-4.272 1.82.535-1.373.723-2.748.602-4.265-.838-1-2.025-2.4-2.025-4.872-.001-4.415 4.485-8.007 9.999-8.007zm0-2c-6.338 0-12 4.226-12 10.007 0 2.05.738 4.063 2.047 5.625.055 1.83-1.023 4.456-1.993 6.368 2.602-.47 6.301-1.508 7.978-2.536 1.418.345 2.775.503 4.059.503 7.084 0 11.91-4.837 11.91-9.961-.001-5.811-5.702-10.006-12.001-10.006z" />
        </svg>
      <span v-if="unread_count!==0" class="badge badge-danger">{{unread_count}}</span>
    </a>
    <div class="dropdown-menu dropdown-menu-right" aria-labbeledby="navbar-notice-list">
      <div class="dropdown-item disabled" v-if="notificationList.length === 0">無資料</div>
      <template v-else>
        <div class="dropdown-item text-center" @click="readAll">全部已讀</div>
        <div class="dropdown-divider"></div>
        <div :class="'dropdown-item '+unreadClass(idx)" v-for="(n, idx) in 5" :v-if="idx < notificationList.length" :key="notificationList[idx].id">
          <a class="text-dark" href="#">{{notificationList[idx].description}}</a>
          <span>{{dateDiffStr(notificationList[idx].timestamp)}}</span>
        </div>
      </template>
      <div class="dropdown-divider"></div>
      <a class="dropdown-item text-center" :href="url">查看所有通知</a>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      notificationList: [],
    }
  },
  methods: {
    dateDiffStr(str) {
      let date = new Date(str);
      let diffInDays = Math.round((Date.now() - date.getTime()) / (1000*60*60*24));
      if (diffInDays < 1) {
        return '今天';
      }
      return diffInDays + '天前'
    },
    getNotificationList() {
      let self = this;
      this.$httpClient.get(`/api/notifications`).then((response) => {
        self.notificationList = response.data;
      }).catch((err) => {
        console.log(err);
      });
    },
    readAll () {
      //TODO:
      console.log('readAll');
    },
    unreadClass(idx) {
      return this.notificationList[idx].unread ? 'unread' : '';
    }
  },
  computed: {
    unread_count() {
      return this.notificationList.reduce((acc, curr) => {
        return acc + (curr.unread === true ? 0 : 1);
      }, 0);
    },
  },
  mounted() {
    let self = this;
    function updateNotificationList() {
      self.getNotificationList();
    }
    updateNotificationList();
    (function loop() {
      let randomOneToFiveMinutes = (Math.random() * 4 * 60 * 1000) + 60 * 1000;
      setTimeout(() => {
        updateNotificationList();
        loop();
      }, randomOneToFiveMinutes);
    })();
  },
  props: ['url'],
}
</script>
<style scoped>

.dropdown-item a {
  max-width: 15rem;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  display: inline-block;
  margin-right: 1rem;
}

.dropdown-item span {
  vertical-align: top;
}

.unread {
  background-color: #eaeae9
}

.unread:hover {
  background-color: #c2c2c2
}

.unread a {
  font-weight: bold;
}
</style>
