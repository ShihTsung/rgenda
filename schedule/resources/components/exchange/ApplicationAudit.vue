<template>
  <div>
    <loading v-if="!isReady"></loading>
    <h4 class="modal-title">待審核表單</h4>
    <vue-good-table
      :columns="columns"
      :rows="rows"
      :search-options="{ enabled: true }"
      :getShiftTimeStr="getShiftTimeStr"
      :approve="approve"
      :reject="reject"
    >
      <template slot="table-row" slot-scope="props">
        <span v-if="props.column.field === 'content'" class="text-nowrap row py-2">
          <span class="col-5">
            <span class="align-middle">{{ props.row.apply_result.user.name }}</span>
            <span class="shift-cell" :style="props.row.apply_result.style">
              <span class="h5 shift-type">{{ props.row.apply_result.shift.name }}</span>
              <span class="shift-time">{{ getShiftTimeStr(props.row.apply_result.shift) }}</span>
              <span class="shift-station">{{ props.row.apply_result.station.name }}</span>
            </span>
          </span>
          <i class="col-1 pt-1" :class="getArrow(props.row)"></i>
          <span class="col-5">
            <span class="align-middle">{{ props.row.receive_result.user.name }}</span>
            <span class="shift-cell" :style="props.row.receive_result.style">
              <span class="h5 shift-type">{{ props.row.receive_result.shift.name }}</span>
              <span class="shift-time">{{ getShiftTimeStr(props.row.receive_result.shift) }}</span>
              <span class="shift-station">{{ props.row.receive_result.station.name }}</span>
            </span>
          </span>
        </span>
        <span v-else-if="props.column.field === 'actions'" class="text-nowrap">
          <div
            class="btn btn-rgenda clickable"
            @click="approve(props.row.id)"
            data-toggle="modal"
            data-target="#approveModal"
          >同意</div>
          <div class="btn btn-rgenda clickable" @click="reject(props.row.id, props.index)">退回</div>
        </span>
        <span v-else-if="props.column.field === 'reason'">
          <input
            name="reject-reason"
            type="text"
            placeholder="請填寫退回理由"
            v-bind="$attrs"
            class="form-control py-2"
          />
        </span>
        <span v-else class="d-inline-block py-2">{{ props.formattedRow[props.column.field] }}</span>
      </template>
      <div slot="emptystate" class="vgt-center-align vgt-text-disabled">無資料</div>
    </vue-good-table>
    <div class="modal fade" id="approveModal" tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
          <div class="modal-header border-bottom-0">
            <button type="button" class="close" aria-label="Close" @click="cancelApprove()">
              <span aria-hidden="true">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
                  <path
                    d="M24 20.188l-8.315-8.209 8.2-8.282-3.697-3.697-8.212 8.318-8.31-8.203-3.666 3.666 8.321 8.24-8.206 8.313 3.666 3.666 8.237-8.318 8.285 8.203z"
                  />
                </svg>
              </span>
            </button>
          </div>
          <div
            class="modal-body text-center pt-0"
            v-if="approveIdx >= 0 && approveIdx < rows.length"
          >
            <h3 class="modal-title mb-4">調整後排班變更如下</h3>
            <div class="row">
              <div class="offset-2 col-8">
                <p class="mb-4">日期：{{ rows[approveIdx].date_start }}-{{ rows[approveIdx].date_end }}</p>
                <div class="row mb-2">
                  <div class="col-4">
                    <span class="align-middle">{{ rows[approveIdx].apply_result.user.name }}</span>
                  </div>
                  <div class="col-8 text-left">
                    <span class="shift-cell" :style="rows[approveIdx].receive_result.style">
                      <span class="h5 shift-type">{{ rows[approveIdx].receive_result.shift.name }}</span>
                      <span
                        class="shift-time"
                      >{{ getShiftTimeStr(rows[approveIdx].receive_result.shift) }}</span>
                      <span class="shift-station">{{ rows[approveIdx].receive_result.station.name }}</span>
                    </span>
                  </div>
                </div>
                <div class="row mb-4">
                  <div class="col-4">
                    <span class="align-middle">{{ rows[approveIdx].receive_result.user.name }}</span>
                  </div>
                  <div class="col-8 text-left">
                    <span class="shift-cell" :style="rows[approveIdx].apply_result.style">
                      <span class="h5 shift-type">{{ rows[approveIdx].apply_result.shift.name }}</span>
                      <span
                        class="shift-time"
                      >{{ getShiftTimeStr(rows[approveIdx].apply_result.shift) }}</span>
                      <span class="shift-station">{{ rows[approveIdx].apply_result.station.name }}</span>
                    </span>
                  </div>
                </div>
                <div class="row">
                  <div class="col mb-2">
                    <button type="button" class="btn btn-rgenda" @click="cancelApprove()">取消</button>
                    <button class="btn btn-rgenda" type="button" @click="confirmApprove()">確定</button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <hr />
    <application-records
      v-if="showRecords"
      :role="role"
      :csrf-token="csrfToken"
      :application-list="applicationList"
    ></application-records>
    <user-shift-calendar v-if="!showRecords"></user-shift-calendar>
  </div>
</template>
<script>
import popup from "common/popup";
import moment from "moment";
import { shiftColor } from "src/constants/color";
import { APPLICATION_STATUS_CONST } from "src/exchange/constants";
import { getShiftTimeStr, getArrow } from "src/exchange/util";
import ApplicationRecords from "./ApplicationRecords.vue";
import UserShiftCalendar from "./UserShiftCalendar.vue";
import Loading from "components/pre-result/Loading.vue";

moment.locale("zh-TW");
export default {
  data() {
    return {
      applicationList: [],
      approveIdx: -1,
      columns: [
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
          label: "審核",
          field: "actions",
          sortable: false,
        },
        {
          label: "退回事由",
          field: "reason",
          sortable: false,
        },
      ],
      isReady: false,
    };
  },
  props: {
    role: {
      type: String,
      default: "",
    },
    isSuperuser: {
      type: null,
      default: null,
    },
    csrfToken: {
      type: String,
      default: "",
    },
  },
  methods: {
    approve(applicationId) {
      this.approveIdx = this.rows.findIndex((row) => row.id === applicationId);
    },
    cancelApprove() {
      $("#approveModal").modal("hide");
      this.approveIdx = -1;
    },
    confirmApprove() {
      $("#approveModal").modal("hide");
      let application = this.rows[this.approveIdx];
      let data = {
        application_status: this.$getNextStep(application.status, "next"),
      };
      let config = {
        headers: {
          "X-CSRFToken": this.csrfToken,
        },
      };
      this.$httpClient
        .patch(`/api/exchange-shift/${application.id}/`, data, config)
        .then(() => {
          this.getExchangeApplications();
        });
    },
    reject(applicationId, index) {
      console.log($('input[name="reject-reason"]')[index].value);
      if ($('input[name="reject-reason"]')[index].value === "") {
        popup.warning({
          title: "請填寫退回理由",
        });
        return false;
      }

      let application = this.applicationList.find((a) => {
        return a.id === applicationId;
      });
      let data = {
        application_status: this.$getNextStep(
          application.application_status,
          "reject"
        ),
        remark: [
          application.remark,
          $('input[name="reject-reason"]')[index].value,
        ].join("\n"),
      };
      let config = {
        headers: {
          "X-CSRFToken": this.csrfToken,
        },
      };
      this.$httpClient
        .patch(`/api/exchange-shift/${applicationId}/`, data, config)
        .then(() => {
          this.getExchangeApplications();
        });
    },
    getExchangeApplications() {
      let self = this;
      let url = "/api/exchange-shift/";
      if (this.role === "user") {
        url += "?mode=personal";
      }
      this.$httpClient
        .get(url)
        .then((response) => {
          self.applicationList = response.data;
          self.isReady = true;
        })
        .catch((err) => {
          console.log(err);
        });
    },
    getShiftStyle(shiftTypeId) {
      let style = "";
      if (shiftColor.hasOwnProperty(shiftTypeId)) {
        let color = shiftColor[shiftTypeId];
        style +=
          `background-color:${color};` +
          `border-color:${color};` +
          `color:${color};`;
      } else {
        let color = shiftColor.default;
        style +=
          `background-color:white;` +
          `border-color:${color};` +
          `color:${color};`;
      }
      return style;
    },
    getShiftTimeStr,
    getArrow,
  },
  computed: {
    showRecords() {
      return (
        ["admin", "manager"].indexOf(this.role) >= 0 ||
        this.isSuperuser.toLowerCase() === "true"
      );
    },
    rows() {
      let list;

      if (this.role === "user" && this.isSuperuser !== "true") {
        list = this.applicationList.filter((application) => {
          return (
            application.application_status ===
            APPLICATION_STATUS_CONST.TO_BE_CONFIRM
          );
        });
      } else {
        list = this.applicationList.filter((application) => {
          return (
            application.application_status ===
            APPLICATION_STATUS_CONST.REVIEWING
          );
        });
      }

      return list.map((application) => {
        let computedApplication = Object.assign({}, application, {
          content: "",
          actions: "",
          reason: "",
          rejectReason: "",
        });
        computedApplication.apply_result.style = this.getShiftStyle(
          application.apply_result.shift.shift_type
        );
        computedApplication.receive_result.style = this.getShiftStyle(
          application.receive_result.shift.shift_type
        );
        return computedApplication;
      });
    },
  },
  mounted() {
    this.getExchangeApplications();
  },
  components: {
    ApplicationRecords,
    UserShiftCalendar,
    Loading,
  },
};
</script>
<style scoped>
::v-deep .shift-cell,
.shift-cell {
  display: inline-block;
  border-radius: 3px;
  padding: 0 3px;
}

::v-deep .shift-type,
.shift-type {
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
::v-deep .shift-station,
.shift-time,
.shift-station {
  position: relative;
  top: -1px;
  background: white;
  border-radius: 3px;
  font-size: 12px;
  padding: 2px;
}
</style>
