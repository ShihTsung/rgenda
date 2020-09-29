<template>
  <div>
    <loading v-if="!isListReady || !isQueryReady" text="載入中..."></loading>
    <h4 class="modal-title">待審核表單</h4>
    <application-list
      :applicationList="applicationList"
      :csrfToken="csrfToken"
      :columns="auditColumns"
      :userName="userName"
    ></application-list>
    <hr />
    <application-query
      v-if="!isUser && currUser"
      :isUser="isUser"
      :toggleReady="toggleQueryReady"
      :userId="userId"
      :departmentId="currUser.department.id"
    ></application-query>
    <user-shift-calendar v-if="isUser"></user-shift-calendar>
  </div>
</template>
<script>
import ApplicationList from "./ApplicationList.vue";
import ApplicationQuery from "./ApplicationQuery.vue";
import UserShiftCalendar from "./UserShiftCalendar.vue";
import Loading from "components/pre-result/Loading.vue";

export default {
  data() {
    return {
      applicationList: [],
      isListReady: false,
      isQueryReady: false,
      auditColumns: [
        {
          label: "單號",
          field: "id",
        },
        {
          label: "起始日期",
          field: "date_start",
        },
        {
          label: "結束日期",
          field: "date_end",
        },
        {
          label: "調班內容",
          field: "content",
          sortable: false,
        },
        {
          label: "審核",
          field: "actions",
          sortable: false,
        },
        {
          label: "退回理由",
          field: "reason",
          sortable: false,
        },
      ],
      currUser: null,
    };
  },
  props: {
    role: {
      type: String,
      default: "",
    },
    isSuperuser: {
      type: String,
      default: "False",
    },
    csrfToken: {
      type: String,
      default: "",
    },
    userId: {
      type: String,
      default: "",
    },
    userName: {
      type: String,
      default: "",
    },
  },
  methods: {
    getCurrUser() {
      this.$httpClient
        .get("/api/users/curr/")
        .then((response) => {
          this.currUser = response.data;
        })
        .catch((err) => {
          console.log(err);
        });
    },
    getExchangeApplications() {
      let url = "/api/exchange-shift/";
      if (this.isUser) {
        url += "?mode=personal";
      }
      this.$httpClient
        .get(url)
        .then((response) => {
          let applicationList = [];
          response.data.forEach((application) => {
            if (
              (this.isUser &&
                this.$userApprovable(application.application_status)) ||
              this.$managerApprovable(application.application_status)
            ) {
              application.approvable = true;
              applicationList.push(application);
            }
          });
          this.applicationList = applicationList;
          this.isListReady = true;
        })
        .catch((err) => {
          console.log(err);
        });
    },
    toggleQueryReady(isReady) {
      if (typeof isReady === "boolean") {
        this.isQueryReady = isReady;
      }
    },
  },
  computed: {
    isUser() {
      return (
        ["admin", "manager"].indexOf(this.role) < 0 &&
        this.isSuperuser.toLowerCase() !== "true"
      );
    },
  },
  mounted() {
    this.getExchangeApplications();
    this.getCurrUser();
    if (this.isUser) {
      this.toggleQueryReady(true);
    }
  },
  components: {
    ApplicationList,
    ApplicationQuery,
    UserShiftCalendar,
    Loading,
  },
};
</script>
<style scoped>
::v-deep .shift-cell {
  display: inline-block;
  border-radius: 3px;
  padding: 0 3px;
}

::v-deep .shift-type {
  vertical-align: top;
  color: white;
  font-weight: 400;
  width: 1.2rem;
  display: inline-block;
  margin: 0;
  text-align: center;
  white-space: nowrap;
  overflow-x: hidden;
}

::v-deep .shift-time,
::v-deep .shift-station {
  position: relative;
  top: -1px;
  background: white;
  border-radius: 3px;
  font-size: 12px;
  padding: 2px;
}
</style>
