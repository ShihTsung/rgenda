<template>
  <div>
    <vue-good-table
      :columns="columns"
      :rows="rows"
      :search-options="{ enabled: true }"
      :getShiftTimeStr="getShiftTimeStr"
      :approve="approve"
      :reject="reject"
    >
      <template slot="table-row" slot-scope="props">
        <span v-if="props.column.field === 'content'" class="text-nowrap">
          <span class="align-middle">{{ props.row.apply_result.user.name }}</span>
          <span class="shift-cell" :style="props.row.apply_result.style">
            <span class="h5 shift-type">{{ props.row.apply_result.shift.name }}</span>
            <span class="shift-time">{{ getShiftTimeStr(props.row.apply_result.shift) }}</span>
            <span class="shift-station">{{ props.row.apply_result.station.name }}</span>
          </span>
          <i class="fas fa-exchange-alt"></i>
          <span class="align-middle">{{ props.row.receive_result.user.name }}</span>
          <span class="shift-cell" :style="props.row.receive_result.style">
            <span class="h5 shift-type">{{ props.row.receive_result.shift.name }}</span>
            <span class="shift-time">{{ getShiftTimeStr(props.row.receive_result.shift) }}</span>
            <span class="shift-station">{{ props.row.receive_result.station.name }}</span>
          </span>
        </span>
        <span v-else-if="props.column.field === 'actions'" class="text-nowrap">
          <div class="btn btn-rgenda clickable" @click="approve(props.row.id)" data-toggle="modal" data-target="#approveModal">同意</div>
          <div class="btn btn-rgenda clickable" @click="reject(props.index)">退回</div>
        </span>
        <span v-else-if="props.column.field === 'reason'">
          <input name="reject-reason" type="text" placeholder="請填寫退回理由" v-bind="$attrs">
        </span>
        <span v-else>{{ props.formattedRow[props.column.field] }}</span>
      </template>
    </vue-good-table>
    <div class="modal fade" id="approveModal" tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
          <div class="modal-header border-bottom-0">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path d="M24 20.188l-8.315-8.209 8.2-8.282-3.697-3.697-8.212 8.318-8.31-8.203-3.666 3.666 8.321 8.24-8.206 8.313 3.666 3.666 8.237-8.318 8.285 8.203z"/></svg>
              </span>
            </button>
          </div>
          <div class="modal-body text-center pt-0" v-if="approveIdx >= 0 && approveIdx < rows.length">
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
                      <span class="shift-time">{{ getShiftTimeStr(rows[approveIdx].receive_result.shift) }}</span>
                      <span class="shift-station">{{ rows[approveIdx].receive_result.station.name }}</span>
                    </span>
                  </div>
                </div>
                <div class="row mb-2">
                  <div class="col-4">
                    <span class="align-middle">{{ rows[approveIdx].receive_result.user.name }}</span>
                  </div>
                  <div class="col-8 text-left">
                    <span class="shift-cell" :style="rows[approveIdx].apply_result.style">
                      <span class="h5 shift-type">{{ rows[approveIdx].apply_result.shift.name }}</span>
                      <span class="shift-time">{{ getShiftTimeStr(rows[approveIdx].apply_result.shift) }}</span>
                      <span class="shift-station">{{ rows[approveIdx].apply_result.station.name }}</span>
                    </span>
                  </div>
                </div>
                <div class="row">
                  <div class="col mb-2">
                    <button class="btn btn-rgenda" type="button"
                      @click="cancelApprove()"
                      data-dismiss="modal">取消</button>
                    <button class="btn btn-rgenda" type="button"
                      @click="confirmApprove()"
                      data-dismiss="modal">確定</button>
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
import popup from 'common/popup';
import moment from 'moment';
import { shiftColor } from 'src/constants/color';
import { APPLICATION_STATUS_CONST } from 'src/exchange/constants';

moment.locale('zh-TW');
export default {
  data() {
    return {
      applicationList: [],
      approveIdx: -1,
      columns: [
        {
          label: '申請單號',
          field: 'id',
        },
        {
          label: '起始日期',
          field: 'date_start',
        },
        {
          label: '結束日期',
          field: 'date_end',
        },
        {
          label: '調班內容',
          field: 'content',
          sortable: false,
        },
        {
          label: '審核',
          field: 'actions',
          sortable: false,
        },
        {
          label: '退回事由',
          field: 'reason',
          sortable: false,
        },
      ],
    };
  },
  props: {
    csrfToken: {
      type: String,
      default: '',
    },
  },
  methods: {
    approve(applicationId) {
      this.approveIdx = this.rows.findIndex(row => row.id === applicationId);
    },
    cancelApprove() {
      this.approveIdx = -1;
    },
    confirmApprove() {
      //TODO: POST modify application status
      this.getExchangeApplications();
    },
    reject(index) {
      console.log($('input[name="reject-reason"]')[index].value);
      if ($('input[name="reject-reason"]')[index].value === '') {
        popup.warning({
          title: '請填寫退回理由',
        });
        return false;
      }
    },
    getExchangeApplications() {
      let self = this;
      this.$httpClient.get('/api/exchange-shift/').then(response => {
        self.applicationList = response.data;
      }).catch((err) => {
        console.log(err);
      });
    },
    getShiftStyle(shiftTypeId) {
      let style = '';
      if (shiftColor.hasOwnProperty(shiftTypeId)) {
        let color = shiftColor[shiftTypeId];
        style += `background-color:${color};`
          + `border-color:${color};`
          + `color:${color};`;
      } else {
        let color = shiftColor.default;
        style += `background-color:white;`
          + `border-color:${color};`
          + `color:${color};`;
      }
      return style;
    },
    getShiftTimeStr(shift) {
      return moment(shift.start, 'HH:mm').format('HH')
        + '-' + moment(shift.end, 'HH:mm').format('HH');
    },
  },
  computed: {
    rows() {
      return this.applicationList.filter((application) => {
        return application.application_status === APPLICATION_STATUS_CONST.REVIEWING;
      }).map((application) => {
        let computedApplication = Object.assign({}, application, {
          content: '',
          actions: '',
          reason: '',
          rejectReason: '',
        });
        computedApplication.apply_result.style = this.getShiftStyle(application.apply_result.shift.shift_type);
        computedApplication.receive_result.style = this.getShiftStyle(application.receive_result.shift.shift_type);
        return computedApplication;
      });
    },
  },
  mounted() {
    this.getExchangeApplications();
  },
};
</script>
<style scoped>
::v-deep .shift-cell, .shift-cell {
  display: inline-block;
  border-radius: 3px;
  padding-inline: 3px;
}

::v-deep .shift-type, .shift-type {
  vertical-align: top;
  color: white;
  font-weight: 400;
}

::v-deep .shift-time, ::v-deep .shift-station, .shift-time, .shift-station {
  position: relative;
  top: -1px;
  background: white;
  border-radius: 3px;
  font-size: 12px;
  padding: 2px;
}
</style>
