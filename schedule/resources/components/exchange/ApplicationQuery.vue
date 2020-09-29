<template>
  <div>
    <h4 class="modal-title">紀錄查詢</h4>
    <div class="row text-nowrap mb-1">
      <div class="col-sm-1 my-auto">
        <span class="align-middle">日期</span>
      </div>
      <div class="col-sm-2 my-auto">
        <date-picker
          v-model="startDate"
          :masks="{L: 'YYYY-MM-DD'}"
          :is-required="true"
          :popover="{visibility: 'focus'}"
        ></date-picker>
      </div>
      <span class="my-auto">-</span>
      <div class="col-sm-2 my-auto">
        <date-picker
          v-model="endDate"
          :masks="{L: 'YYYY-MM-DD'}"
          :is-required="true"
          :popover="{visibility: 'focus'}"
        ></date-picker>
      </div>
      <div class="col-sm-2 my-auto">
        <div class="btn btn-rgenda clickable" @click="query()">查詢</div>
      </div>
    </div>
    <div class="row mb-2">
      <div class="col-sm-1 my-auto">
        <span class="align-middle">狀態</span>
      </div>
      <div class="col-sm-2 my-auto">
        <select class="form-control" v-model="status">
          <option
            v-for="option in statusOptions"
            :key="option.value"
            :value="option.value"
          >{{ option.text }}</option>
        </select>
      </div>
    </div>
    <vue-good-table :columns="columns" :rows="rows" class="text-nowrap">
      <template slot="table-row" slot-scope="props">
        <span v-if="props.column.field === 'content'" class="text-nowrap row justify-content-center">
          <span class="col-5">
            <span class="shift-cell" :style="props.row.apply_result.style">
              <span class="h5 shift-type">{{ props.row.apply_result.shift.name }}</span>
              <span class="shift-time">{{ getShiftTimeStr(props.row.apply_result.shift) }}</span>
              <span class="shift-station">{{ props.row.apply_result.station.name }}</span>
            </span>
          </span>
          <i class="col-1" :class="getArrow(props.row)"></i>
          <span class="col-5">
            <span class="shift-cell" :style="props.row.receive_result.style">
              <span class="h5 shift-type">{{ props.row.receive_result.shift.name }}</span>
              <span class="shift-time">{{ getShiftTimeStr(props.row.receive_result.shift) }}</span>
              <span class="shift-station">{{ props.row.receive_result.station.name }}</span>
            </span>
          </span>
        </span>
        <span v-else>{{ props.formattedRow[props.column.field] }}</span>
      </template>
      <div slot="emptystate" class="vgt-center-align vgt-text-disabled">無資料</div>
    </vue-good-table>
  </div>
</template>
<script>
import moment from "moment";
import DatePicker from "v-calendar/lib/components/date-picker.umd";
import { shiftColor } from "src/constants/color";
import { getShiftTimeStr, getArrow } from "src/exchange/util";

export default {
  components: {
    DatePicker,
  },
  props: {
    isUser: {
      type: Boolean,
      default: true,
    },
    toggleReady: {
      type: Function,
      default: null,
    }
  },
  data() {
    return {
      startDate: moment().subtract(1, "months").toDate(),
      endDate: moment().toDate(),
      status: 0,
      statusOptions: [
        { text: "已生效", value: 2 },
        { text: "退回", value: 3 },
      ],
      columns: [
        {
          label: "申請單號",
          field: "id",
        },
        {
          label: "申請日期",
          field: "application_date",
        },
        {
          label: "期間",
          field: "exchange_period",
        },
        {
          label: "申請人員",
          field: "applicant",
        },
        {
          label: "調班人員",
          field: "exchange_target",
        },
        {
          label: "班別更動",
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
      ],
      applicationList: [],
    };
  },
  methods: {
    getShiftStyle(shift) {
      let style = "";
      if (shiftColor.hasOwnProperty(shift.shift_type)) {
        let color = shiftColor[shift.shift_type];
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
    query() {
      this.toggleReady(false);
      let url = "/api/exchange-shift/"; //TODO: 以 department 查詢
      if (this.isUser) {
        url += "?mode=personal";
      }
      this.$httpClient.get(url).then((res) => {
        this.applicationList = res.data;
        this.toggleReady(true);
      });
    },
  },
  computed: {
    rows() {
      return this.applicationList.map((application) => {
        let computedApplication = Object.assign({}, application, {
          application_date: "", //TODO: created_at
          exchange_period:
            application.date_start + " - " + application.date_end,
          applicant: application.apply_result.user.name,
          exchange_target: application.receive_result.user.name,
          content: application.content,
          statusText: this.$getApplicationStatusString(
            application.application_status
          ),
        });
        computedApplication.apply_result.style = this.getShiftStyle(
          application.apply_result.shift
        );
        computedApplication.receive_result.style = this.getShiftStyle(
          application.receive_result.shift
        );
        return computedApplication;
      });
    },
  },
  mounted() {
    this.query();
  },
};
</script>
<style scoped>
</style>
