<template>
  <div>
    <div class="row text-nowrap">
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
      <div class="col-sm-1 my-auto">
        <span class="align-middle">狀態</span>
      </div>
      <div class="col-sm-2 my-auto">
        <select class="form-control" v-model="status">
          <option v-for="option in statusOptions" :key="option.value" :value="option.value">
            {{ option.text }}
          </option>
        </select>
      </div>
      <div class="col-sm-2 my-auto">
        <div class="btn btn-rgenda clickable" @click="query()">查詢</div>
      </div>
    </div>
    <vue-good-table
      :columns="columns"
      :rows="rows"
      class="text-nowrap"
    >
      <template slot="table-row" slot-scope="props">
        <span v-if="props.column.field === 'content'" class="text-nowrap">
          <span class="shift-cell" :style="props.row.exchange_from.style">
            <span class="h5 shift-type">{{ props.row.exchange_from.shift_type }}</span>
            <span class="shift-time">{{ getShiftTimeStr(props.row.exchange_from.shift) }}</span>
            <span class="shift-station">{{ props.row.exchange_from.station.name }}</span>
          </span>
          <i class="fas fa-exchange-alt"></i>
          <span class="shift-cell" :style="props.row.exchange_to.style">
            <span class="h5 shift-type">{{ props.row.exchange_to.shift_type }}</span>
            <span class="shift-time">{{ getShiftTimeStr(props.row.exchange_to.shift) }}</span>
            <span class="shift-station">{{ props.row.exchange_to.station.name }}</span>
          </span>
        </span>
        <span v-else>{{ props.formattedRow[props.column.field] }}</span>
      </template>
    </vue-good-table>
  </div>
</template>
<script>
import moment from 'moment';
import DatePicker from 'v-calendar/lib/components/date-picker.umd';
import { shiftColor } from 'src/constants/color';

export default {
  components: {
    DatePicker,
  },
  data() {
    return {
      startDate: moment().subtract(1, 'months').toDate(),
      endDate: moment().toDate(),
      status: 0,
      applicationList: [],
      statusOptions: [
        { text: '全部', value: 0 },
        { text: '待審核', value: 1 },
        { text: '已生效', value: 2 },
        { text: '退回', value: 3 },
      ],
      columns: [
        {
          label: '申請單號',
          field: 'no',
        },
        {
          label: '申請日期',
          field: 'application_date',
        },
        {
          label: '期間',
          field: 'exchange_period',
        },
        {
          label: '申請人員',
          field: 'applicant',
        },
        {
          label: '調班人員',
          field: 'exchange_target',
        },
        {
          label: '班別更動',
          field: 'content',
          sortable: false,
        },
        {
          label: '流程狀態',
          field: 'status',
        },
        {
          label: '事由',
          field: 'reason',
          sortable: false,
        },
      ],
    }
  },
  methods: {
    getShiftStyle(shift) {
      let style = '';
      if (shiftColor.hasOwnProperty(shift.shift_type)) {
        let color = shiftColor[shift.shift_type];
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
      return moment(shift.start_time, 'HH:mm').format('HH')
        + '-' + moment(shift.end_time, 'HH:mm').format('HH');
    },
    query() {
      //TODO: GET exchange application API
      this.applicationList = [
        {
          id: 1,
          no: 'S20200706003',
          start_date: '2020/05/26',
          end_date: '2020/05/28',
          status: 1,
          reason: '',
          exchange_from: {
            id: 3,
            user: {
              id: 3,
              username: 'user1',
              email: 'user1@redfalcon-hpc.com',
              full_name: '亭惠',
              department: {
                id: 1,
                name: 'D1',
                detail: '健檢診所',
                limit_pre_schedule: 3,
                deadline_pre_schedule: 19,
                reset: 0,
                law_rule: 0,
                schedule_rule: 0,
                admin_in_schedule: false,
                same_day_notice: 5,
                date_start: '2020-06-09',
              },
              level: 1,
              is_senior: false,
              gender: 'female',
              role: 'user',
              is_superuser: false,
              type_of_user: '正職',
              can_be_scheduled: true,
              holiday_rest_num: 40,
              special_rest_num: 10,
              hour_required: 100,
              hour_realized: 0,
              eid: '12405143',
              onboard_date: null,
            },
            shift: {
              id: 9,
              name: 'B1',
              shift_type: 0,
              start_time: '07:00',
              end_time: '15:30',
              department: {
                id: 1,
                name: 'D1',
                detail: '健檢診所',
                limit_pre_schedule: 3,
                deadline_pre_schedule: 19,
                reset: 0,
                law_rule: 0,
                schedule_rule: 0,
                admin_in_schedule: false,
                same_day_notice: 5,
                date_start: '2020-06-09',
              },
              work_hours: 8,
            },
            date: '2020-06-01',
            station: {
              id: 8,
              name: '健康秘書',
              department: 1,
            },
            shift_type: 'A',
          },
          exchange_to: {
            id: 2,
            user: {
              id: 2,
              username: 'user0',
              email: 'user0@redfalcon-hpc.com',
              full_name: '惠如',
              department: {
                id: 1,
                name: 'D1',
                detail: '健檢診所',
                limit_pre_schedule: 3,
                deadline_pre_schedule: 19,
                reset: 0,
                law_rule: 0,
                schedule_rule: 0,
                admin_in_schedule: false,
                same_day_notice: 5,
                date_start: '2020-06-09',
              },
              level: 1,
              is_senior: false,
              gender: 'female',
              role: 'user',
              is_superuser: false,
              type_of_user: '正職',
              can_be_scheduled: true,
              holiday_rest_num: 40,
              special_rest_num: 10,
              hour_required: 100,
              hour_realized: 0,
              eid: '12405142',
              onboard_date: null,
            },
            shift: {
              id: 13,
              name: 'B3',
              shift_type: 0,
              start_time: '07:03',
              end_time: '16:30',
              department: {
                id: 1,
                name: 'D1',
                detail: '健檢診所',
                limit_pre_schedule: 3,
                deadline_pre_schedule: 19,
                reset: 0,
                law_rule: 0,
                schedule_rule: 0,
                admin_in_schedule: false,
                same_day_notice: 5,
                date_start: '2020-06-09',
              },
              work_hours: 9,
            },
            date: '2020-06-01',
            station: {
              id: 9,
              name: '一般',
              department: 1,
            },
            shift_type: 'A',
          },
        },
        {
          id: 2,
          no: 'S20200706003',
          start_date: '2020/05/26',
          end_date: '2020/05/28',
          status: 1,
          exchange_from: {
            id: 3,
            user: {
              id: 3,
              username: 'user1',
              email: 'user1@redfalcon-hpc.com',
              full_name: '亭惠',
              department: {
                id: 1,
                name: 'D1',
                detail: '健檢診所',
                limit_pre_schedule: 3,
                deadline_pre_schedule: 19,
                reset: 0,
                law_rule: 0,
                schedule_rule: 0,
                admin_in_schedule: false,
                same_day_notice: 5,
                date_start: '2020-06-09',
              },
              level: 1,
              is_senior: false,
              gender: 'female',
              role: 'user',
              is_superuser: false,
              type_of_user: '正職',
              can_be_scheduled: true,
              holiday_rest_num: 40,
              special_rest_num: 10,
              hour_required: 100,
              hour_realized: 0,
              eid: '12405143',
              onboard_date: null,
            },
            shift: {
              id: 9,
              name: 'B1',
              shift_type: 0,
              start_time: '07:00',
              end_time: '15:30',
              department: {
                id: 1,
                name: 'D1',
                detail: '健檢診所',
                limit_pre_schedule: 3,
                deadline_pre_schedule: 19,
                reset: 0,
                law_rule: 0,
                schedule_rule: 0,
                admin_in_schedule: false,
                same_day_notice: 5,
                date_start: '2020-06-09',
              },
              work_hours: 8,
            },
            date: '2020-06-01',
            station: {
              id: 8,
              name: '健康秘書',
              department: 1,
            },
            shift_type: 'A',
          },
          exchange_to: {
            id: 2,
            user: {
              id: 2,
              username: 'user0',
              email: 'user0@redfalcon-hpc.com',
              full_name: '惠如',
              department: {
                id: 1,
                name: 'D1',
                detail: '健檢診所',
                limit_pre_schedule: 3,
                deadline_pre_schedule: 19,
                reset: 0,
                law_rule: 0,
                schedule_rule: 0,
                admin_in_schedule: false,
                same_day_notice: 5,
                date_start: '2020-06-09',
              },
              level: 1,
              is_senior: false,
              gender: 'female',
              role: 'user',
              is_superuser: false,
              type_of_user: '正職',
              can_be_scheduled: true,
              holiday_rest_num: 40,
              special_rest_num: 10,
              hour_required: 100,
              hour_realized: 0,
              eid: '12405142',
              onboard_date: null,
            },
            shift: {
              id: 13,
              name: 'B3',
              shift_type: 0,
              start_time: '07:03',
              end_time: '16:30',
              department: {
                id: 1,
                name: 'D1',
                detail: '健檢診所',
                limit_pre_schedule: 3,
                deadline_pre_schedule: 19,
                reset: 0,
                law_rule: 0,
                schedule_rule: 0,
                admin_in_schedule: false,
                same_day_notice: 5,
                date_start: '2020-06-09',
              },
              work_hours: 9,
            },
            date: '2020-06-01',
            station: {
              id: 9,
              name: '一般',
              department: 1,
            },
            shift_type: 'A',
          },
        },
      ];
    },
  },
  computed: {
    rows() {
      return this.applicationList.map(application => {
        let computedApplication = Object.assign({}, application, {
          application_date: '',
          exchange_period: application.start_date + ' - ' + application.end_date,
          applicant: application.exchange_from.user.full_name,
          exchange_target: application.exchange_to.user.full_name,
          content: '',
        });
        computedApplication.exchange_from.style = this.getShiftStyle(application.exchange_from.shift);
        computedApplication.exchange_to.style = this.getShiftStyle(application.exchange_to.shift);
        return computedApplication;
      });
    },
  },
  mounted() {
    this.query();
  },
}
</script>
<style scoped>
::v-deep .shift-cell {
  display: inline-block;
  border-radius: 3px;
  padding-inline: 3px;
}

::v-deep .shift-type {
  vertical-align: top;
  color: white;
  font-weight: 400;
}

::v-deep .shift-time, ::v-deep .shift-station {
  background: white;
  border-radius: 3px;
  font-size: 12px;
  padding: 2px;
}
</style>
