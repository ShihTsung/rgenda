<template>
  <div>
    <loading v-if="!isListReady || !isQueryReady" text="載入中..."></loading>
    <div class="row mb-2">
      <div class="modal-title h4 col-11">流程中表單</div>
      <div class="col-1">
        <div class="float-right">
          <div
            class="btn icon-bts m-0"
            data-tooltip="tooltip"
            title="新增調班申請"
            data-toggle="modal"
            data-target="#createApplicationModal"
          >
            <svg
              xmlns="http://www.w3.org/2000/svg"
              class="icon-color"
              width="24"
              height="24"
              viewBox="0 0 24 24"
            >
              <path d="M24 10h-10v-10h-4v10h-10v4h10v10h4v-10h10z" />
            </svg>
          </div>
        </div>
      </div>
    </div>
    <div
      class="modal fade"
      id="createApplicationModal"
      tabindex="-1"
      role="dialog"
      aria-hidden="true"
    >
      <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
          <div class="modal-header border-bottom-0">
            <button
              type="button"
              class="close"
              aria-label="Close"
              @click="cancelCreate()"
            >
              <span aria-hidden="true">
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  width="24"
                  height="24"
                  viewBox="0 0 24 24"
                >
                  <path
                    d="M24 20.188l-8.315-8.209 8.2-8.282-3.697-3.697-8.212 8.318-8.31-8.203-3.666 3.666 8.321 8.24-8.206 8.313 3.666 3.666 8.237-8.318 8.285 8.203z"
                  />
                </svg>
              </span>
            </button>
          </div>
          <div class="modal-body pt-0 pb-4">
            <h3 class="modal-title mb-4 text-center">調班申請</h3>
            <div class="form-group text-center">
              <label>申請區間</label>
              <div class="row justify-content-center">
                <date-picker
                  v-model="createApplicationData.range"
                  mode="range"
                  :masks="{ L: 'YYYY-MM-DD' }"
                  :is-required="true"
                  is-inline
                  locale="zh-TW"
                ></date-picker>
              </div>
              <p
                v-if="
                  createApplicationData.errMsg &&
                  createApplicationData.errMsg.length > 0
                "
                class="form-text text-danger"
              >
                {{ createApplicationData.errMsg }}
              </p>
            </div>
            <template
              v-if="
                createApplicationData.errMsg === '' &&
                createApplicationData.range &&
                createApplicationData.applyResult
              "
            >
              <hr />
              <div class="form-row mb-2">
                <label class="col-4 col-form-label offset-1">原排班別</label>
                <input
                  type="text"
                  readonly
                  class="col-6 form-control-plaintext"
                  :value="createApplicationData.applyResult.shift.name"
                />
              </div>
              <div class="form-row mb-2">
                <label class="col-4 col-form-label offset-1">欲換班別</label>
                <select
                  class="col-6 form-control"
                  v-model="createApplicationData.targetShiftType"
                >
                  <template v-for="shiftType in shiftTypeList">
                    <option
                      v-if="
                        shiftType.id !==
                        createApplicationData.applyResult.shift.shift_type
                      "
                      :key="shiftType.id"
                      :value="shiftType.id"
                    >
                      {{ shiftType.text }}
                    </option>
                  </template>
                </select>
              </div>
              <div class="form-row mb-2">
                <label class="col-4 col-form-label offset-1">換班人員</label>
                <select
                  class="col-6 form-control"
                  v-model="createApplicationData.userReceive"
                >
                  <template v-for="user in validUserList">
                    <option :key="user.id" :value="user.id">
                      {{ user.full_name }}
                    </option>
                  </template>
                </select>
                <small
                  v-if="
                    typeof createApplicationData.targetShiftType === 'number' &&
                    validUserList.length === 0
                  "
                  class="form-text text-danger offset-1 col-10"
                >
                  查無可選換班人員，請重新選擇欲換班別。
                </small>
              </div>
            </template>
            <div v-if="createApplicationData.userReceive" class="row">
              <div class="col mt-2 text-center">
                <button
                  type="button"
                  class="btn btn-rgenda"
                  @click="cancelCreate()"
                >
                  取消
                </button>
                <button
                  class="btn btn-rgenda"
                  type="button"
                  @click="confirmCreate()"
                >
                  確定
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <application-list
      :applicationList="applicationList"
      :csrfToken="csrfToken"
      :columns="recordColumns"
    ></application-list>
    <hr />
    <application-query
      :isUser="isUser"
      :toggleReady="toggleQueryReady"
    ></application-query>
  </div>
</template>

<script>
import { SHIFT_TYPE } from "src/shifts/constants";
import { APPLICATION_STATUS_CONST } from "src/exchange/constants";
import DatePicker from "v-calendar/lib/components/date-picker.umd";
import ApplicationList from "./ApplicationList.vue";
import ApplicationQuery from "./ApplicationQuery.vue";
import Loading from "components/pre-result/Loading.vue";
export default {
  components: {
    DatePicker,
    ApplicationList,
    ApplicationQuery,
    Loading,
  },
  data() {
    return {
      applicationList: [],
      isListReady: false,
      isQueryReady: false,
      currUser: null,
      createApplicationData: {},
      recordColumns: [
        {
          label: "申請單號",
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
          label: "狀態",
          field: "statusText",
          sortable: false,
        },
        {
          label: "備註",
          field: "remark",
          sortable: false,
        },
        {
          label: "動作",
          field: "actions",
          sortable: false,
        },
      ],
      shiftTypeList: [
        {
          id: SHIFT_TYPE.VALUE_DAY_SHIFT,
          text: this.$getShiftTypeText(SHIFT_TYPE.VALUE_DAY_SHIFT),
        },
        {
          id: SHIFT_TYPE.VALUE_NIGHT_SHIFT,
          text: this.$getShiftTypeText(SHIFT_TYPE.VALUE_NIGHT_SHIFT),
        },
        {
          id: SHIFT_TYPE.VALUE_GRAVEYARD_SHIFT,
          text: this.$getShiftTypeText(SHIFT_TYPE.VALUE_GRAVEYARD_SHIFT),
        },
      ],
      exchangeUserList: [],
      rangeResults: [],
      users: [],
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
      this.isListReady = false;
      this.$httpClient
        .get("/api/exchange-shift/") //TODO: 以 user_apply 查詢
        .then((response) => {
          let applicationList = [];
          response.data.forEach((application) => {
            if (application.user_apply === parseInt(this.userId)) {
              application.withdrawable = this.$withdrawable(
                application.application_status
              );

              application.confirmable =
                this.$confirmable(application.application_status) &&
                application.is_confirmed !== 1;

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
    getExchangeUserList() {
      if (this.createApplicationData.range && this.rangeResults) {
        let exchangeUserList = {};
        this.rangeResults.forEach((item) => {
          if (this.isWorkShift(item.shift.shift_type)) {
            if (!exchangeUserList[item.shift.shift_type]) {
              exchangeUserList[item.shift.shift_type] = {};
            }
            if (!exchangeUserList[item.shift.shift_type][item.user]) {
              exchangeUserList[item.shift.shift_type][item.user] = {
                shiftId: item.shift.id,
                count: 0,
              };
            }
            exchangeUserList[item.shift.shift_type][item.user].count += 1;
          }
        });
        this.exchangeUserList = exchangeUserList;
      } else {
        this.exchangeUserList = {};
      }
    },
    validate() {
      let errMsg = "";
      let applyResult = null;
      for (const result of this.rangeResults) {
        if (result.user === parseInt(this.userId)) {
          if (!applyResult) {
            applyResult = result;
          } else if (applyResult.shift.id !== result.shift.id) {
            errMsg = "申請區間包含多種班別，請分別提送申請。";
            break;
          }
        }
      }
      if (!applyResult || !this.isWorkShift(applyResult.shift.shift_type)) {
        errMsg = "不可申請調換值班以外的班別，請選擇其他時間區間。";
      }
      this.$set(this.createApplicationData, "errMsg", errMsg);
      this.$set(this.createApplicationData, "applyResult", applyResult);
    },
    isWorkShift(shiftType) {
      if (shiftType) {
        return (
          this.shiftTypeList.findIndex((shift) => shift.id === shiftType) >= 0
        );
      }
      return false;
    },
    getUsers() {
      let url = "/api/users/";
      if (this.currUser && parseInt(this.currUser.department.id) > 0) {
        url += "?department=" + this.currUser.department.id;
      }
      this.$httpClient.get(url).then((response) => {
        this.users = response.data;
      });
    },
    getDateString(date) {
      return new Date(date.getTime() - date.getTimezoneOffset() * 60000)
        .toISOString()
        .split("T")[0];
    },
    init() {
      this.createApplicationData = {
        range: null,
        errMsg: "",
        userReceive: null,
        applyResult: null,
        targetShiftType: null,
      };
    },
    cancelCreate() {
      $("#createApplicationModal").modal("hide");
      this.init();
    },
    confirmCreate() {
      $("#createApplicationModal").modal("hide");
      this.isListReady = false;
      let data = {
        date_start: this.getDateString(this.createApplicationData.range.start),
        date_end: this.getDateString(this.createApplicationData.range.end),
        application_status: APPLICATION_STATUS_CONST.TO_BE_CONFIRM,
        remark: null,
        user_apply: this.userId,
        user_receive: this.createApplicationData.userReceive,
      };
      const config = {
        headers: {
          "X-CSRFToken": `${this.csrfToken}`,
        },
      };
      this.$httpClient.post("/api/exchange-shift/", data, config).then(() => {
        this.getExchangeApplications();
      });
    },
  },
  computed: {
    isUser() {
      return (
        ["admin", "manager"].indexOf(this.role) < 0 &&
        this.isSuperuser.toLowerCase() !== "true"
      );
    },
    selectedRange() {
      return this.createApplicationData.range;
    },
    validUserList() {
      if (
        this.users &&
        this.createApplicationData.targetShiftType &&
        this.exchangeUserList[this.createApplicationData.targetShiftType]
      ) {
        let targetType = this.createApplicationData.targetShiftType;
        let userList = [];
        for (const key in this.exchangeUserList[targetType]) {
          const userId = parseInt(key);
          let start = this.createApplicationData.range.start;
          let end = this.createApplicationData.range.end;
          let diffDays = Math.round((end - start) / (1000 * 60 * 60 * 24)) + 1;
          if (
            this.userId !== key &&
            this.exchangeUserList[targetType][userId].count === diffDays
          ) {
            let user = this.users.find((u) => u.id === userId);
            userList.push(user);
          }
        }
        return userList;
      }
      return [];
    },
  },
  watch: {
    selectedRange() {
      if (this.createApplicationData.range) {
        let start = this.getDateString(this.createApplicationData.range.start);
        let end = this.getDateString(this.createApplicationData.range.end);
        this.$httpClient
          .get(`/api/results/?start=${start}&end=${end}`)
          .then((response) => {
            this.rangeResults = response.data;
            this.getExchangeUserList();
            this.validate();
          });
      }
    },
  },
  mounted() {
    this.getCurrUser();
    this.getExchangeApplications();
    this.getUsers();
    this.init();
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
