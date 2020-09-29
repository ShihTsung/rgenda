<template>
  <div>
    <vue-good-table
      :columns="columns"
      :rows="rows"
      :search-options="{ enabled: true }"
    >
      <template slot="table-row" slot-scope="props">
        <span
          v-if="props.column.field === 'content'"
          class="text-nowrap row py-2 justify-content-center"
        >
          <span class="col-5">
            <span class="align-middle">{{
              props.row.user_apply
                ? props.row.apply_result.user.name
                : props.row.receive_result.user.name
            }}</span>
            <span class="shift-cell" :style="props.row.apply_result.style">
              <span class="h5 shift-type">{{
                props.row.apply_result.shift.name
              }}</span>
              <span class="shift-time">{{
                getShiftTimeStr(props.row.apply_result.shift)
              }}</span>
              <span class="shift-station">{{
                props.row.apply_result.station.name
              }}</span>
            </span>
          </span>
          <i class="col-1 pt-1" :class="getArrow(props.row)"></i>
          <span class="col-5">
            <span class="shift-cell" :style="props.row.receive_result.style">
              <span class="h5 shift-type">{{
                props.row.receive_result.shift.name
              }}</span>
              <span class="shift-time">{{
                getShiftTimeStr(props.row.receive_result.shift)
              }}</span>
              <span class="shift-station">{{
                props.row.receive_result.station.name
              }}</span>
            </span>
            <span class="align-middle" v-if="props.row.user_apply">{{
              props.row.receive_result.user.name
            }}</span>
          </span>
        </span>
        <span v-else-if="props.column.field === 'actions'" class="text-nowrap">
          <template v-if="props.row.approvable">
            <div
              class="btn btn-rgenda clickable"
              @click="approve(props.row.id)"
              data-toggle="modal"
              data-target="#approveModal"
            >
              同意
            </div>
            <div
              class="btn btn-rgenda clickable"
              @click="reject(props.row.id, props.index)"
            >
              退回
            </div>
          </template>
          <div
            v-if="props.row.withdrawable"
            class="btn btn-rgenda clickable"
            @click="withdraw(props.row.id)"
          >
            撤回
          </div>
          <div
            v-if="props.row.confirmable"
            class="btn btn-rgenda clickable"
            @click="confirm(props.row.id)"
          >
            確認
          </div>
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
        <span v-else class="d-inline-block py-2">{{
          props.formattedRow[props.column.field]
        }}</span>
      </template>
      <div slot="emptystate" class="vgt-center-align vgt-text-disabled">
        無資料
      </div>
    </vue-good-table>
    <div
      class="modal fade"
      id="approveModal"
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
              @click="cancelApprove()"
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
          <div
            class="modal-body text-center pt-0"
            v-if="approveIdx >= 0 && approveIdx < rows.length"
          >
            <h3 class="modal-title mb-4">調整後排班變更如下</h3>
            <div class="row">
              <div class="offset-2 col-8">
                <p class="mb-4">
                  日期：{{ rows[approveIdx].date_start }} ~
                  {{ rows[approveIdx].date_end }}
                </p>
                <div class="row mb-2">
                  <div class="col-4">
                    <span class="align-middle">{{
                      rows[approveIdx].apply_result.user.name
                    }}</span>
                  </div>
                  <div class="col-8 text-left">
                    <span
                      class="shift-cell"
                      :style="rows[approveIdx].receive_result.style"
                    >
                      <span class="h5 shift-type">{{
                        rows[approveIdx].receive_result.shift.name
                      }}</span>
                      <span class="shift-time">{{
                        getShiftTimeStr(rows[approveIdx].receive_result.shift)
                      }}</span>
                      <span class="shift-station">{{
                        rows[approveIdx].receive_result.station.name
                      }}</span>
                    </span>
                  </div>
                </div>
                <div class="row mb-4">
                  <div class="col-4">
                    <span class="align-middle">{{
                      rows[approveIdx].receive_result.user.name
                    }}</span>
                  </div>
                  <div class="col-8 text-left">
                    <span
                      class="shift-cell"
                      :style="rows[approveIdx].apply_result.style"
                    >
                      <span class="h5 shift-type">{{
                        rows[approveIdx].apply_result.shift.name
                      }}</span>
                      <span class="shift-time">{{
                        getShiftTimeStr(rows[approveIdx].apply_result.shift)
                      }}</span>
                      <span class="shift-station">{{
                        rows[approveIdx].apply_result.station.name
                      }}</span>
                    </span>
                  </div>
                </div>
                <div class="row">
                  <div class="col mb-2">
                    <button
                      type="button"
                      class="btn btn-rgenda"
                      @click="cancelApprove()"
                    >
                      取消
                    </button>
                    <button
                      class="btn btn-rgenda"
                      type="button"
                      @click="confirmApprove()"
                    >
                      確定
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div
      class="modal fade"
      id="withdrawModal"
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
              @click="cancelWithdraw()"
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
          <div
            class="modal-body text-center pt-0"
            v-if="withdrawIdx >= 0 && withdrawIdx < rows.length"
          >
            <h3 class="modal-title mb-4">撤回申請</h3>
            <div class="row">
              <div class="offset-2 col-8">
                <p class="mb-2">您即將撤回此筆申請：</p>
                <p class="mb-4">
                  日期：{{ rows[withdrawIdx].date_start }} ~
                  {{ rows[withdrawIdx].date_end }}
                </p>
                <p class="mb-2">
                  原排班別：
                  <span
                    class="shift-cell"
                    :style="rows[withdrawIdx].apply_result.style"
                  >
                    <span class="h5 shift-type">{{
                      rows[withdrawIdx].apply_result.shift.name
                    }}</span>
                    <span class="shift-time">{{
                      getShiftTimeStr(rows[withdrawIdx].apply_result.shift)
                    }}</span>
                    <span class="shift-station">{{
                      rows[withdrawIdx].apply_result.station.name
                    }}</span>
                  </span>
                </p>
                <p class="mb-2">
                  欲換班別：
                  <span
                    class="shift-cell"
                    :style="rows[withdrawIdx].receive_result.style"
                  >
                    <span class="h5 shift-type">{{
                      rows[withdrawIdx].receive_result.shift.name
                    }}</span>
                    <span class="shift-time">{{
                      getShiftTimeStr(rows[withdrawIdx].receive_result.shift)
                    }}</span>
                    <span class="shift-station">{{
                      rows[withdrawIdx].receive_result.station.name
                    }}</span>
                  </span>
                </p>
                <p class="mb-4">
                  換班人員：{{ rows[withdrawIdx].receive_result.user.name }}
                </p>
                <div class="row">
                  <div class="col mb-2">
                    <button
                      type="button"
                      class="btn btn-rgenda"
                      @click="cancelWithdraw()"
                    >
                      取消
                    </button>
                    <button
                      class="btn btn-rgenda"
                      type="button"
                      @click="confirmWithdraw()"
                    >
                      確定
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import popup from "common/popup";
import { shiftColor } from "src/constants/color";
import { getShiftTimeStr, getArrow } from "src/exchange/util";
export default {
  props: {
    applicationList: {
      type: Array,
      default: function () {
        return [];
      },
      required: true,
    },
    csrfToken: {
      type: String,
      default: "",
      required: true,
    },
    columns: {
      type: Array,
      default: function () {
        return [];
      },
      required: true,
    },
    userName: {
      type: String,
      default: "",
    },
  },
  data() {
    return {
      approveIdx: -1,
      withdrawIdx: -1,
    };
  },
  methods: {
    getShiftTimeStr,
    getArrow,
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
        application_status: this.$getNextStep(
          application.application_status,
          "next"
        ),
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
      let rejectReason = $('input[name="reject-reason"]')[index].value;
      if (rejectReason === "") {
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
        remark: [application.remark, this.userName + ": " + rejectReason].join(
          "\n"
        ),
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
    withdraw(applicationId) {
      this.withdrawIdx = this.rows.findIndex((row) => row.id === applicationId);
    },
    cancelWithdraw() {
      $("#withdrawModal").modal("hide");
      this.withdrawIdx = -1;
    },
    confirmWithdraw() {
      $("#withdrawModal").modal("hide");
      let application = this.rows[this.withdrawIdx];
      const config = {
        headers: {
          "X-CSRFToken": this.csrfToken,
        },
      };
      this.$httpClient
        .delete(`/api/exchange-shift/${application.id}/`, config)
        .then(() => {
          this.getExchangeApplications();
        });
    },
    confirm(applicationId) {
      let data = {
        is_confirmed: 1, //TODO: 與後端確認欄位名稱
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
  },
  computed: {
    rows() {
      return this.applicationList.map((application) => {
        let computedApplication = Object.assign({}, application, {
          content: "",
          actions: "",
          reason: "",
          statusText: this.$getApplicationStatusString(
            application.application_status
          ),
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
};
</script>
<style>
</style>
