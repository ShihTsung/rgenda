<template>
<div>
  <div class="container-fluid">
    <div class="row">
      <!-- Query UI -->
      <div class="col-12 p-0">
        <div class="card collapse-card" id="accordionQueryUI">
          <div class="card-header bg-white">
            <div class="card-title mb-0">
              <h4 class="rgenda-text-dark-blue mb-0">個人查詢
                <div class="float-right">
                  <button type="button" class="btn btn-tool" data-toggle="collapse" data-target="#collapseQueryUI"
                  aria-expanded="true" aria-controls="collapseQueryUI"><i class="fas fa-minus"></i></button>
                </div>
              </h4>
            </div>
          </div>
          <div id="collapseQueryUI" class="collapse show" aria-labelledby="headingQueryUI" data-parent="#accordionQueryUI">
            <div class="card-body">
              <div class="form-group">
                <label class="font-weight-bold">查詢項目</label>
                <div class="form-group">
                  <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio"
                    id="rdo_type_all" value="1"
                    v-model="selectedType">
                    <label class="form-check-label" for="rdo_type_all">出勤紀錄</label>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="font-weight-bold">查詢年月</label>
                <div class="row">
                  <div class="col-3">
                    <vue-monthly-picker
                    v-model="selectedYearMonth"
                    dateFormat="YYYY-MM"
                    :max="maxYearMonth"
                    >
                    </vue-monthly-picker>
                  </div>
                </div>
              </div>
            </div>
            <div class="card-footer">
              <button type="button" class="btn btn-rgenda" @click="query()">查詢</button>
            </div>
          </div>
        </div>
      </div>
      <!-- \Query UI -->

      <!-- Result UI -->
      <div class="col-12 p-0 mt-4" v-show="showResult">
        <div class="card" id="accordionResultUI">
          <div class="card-header bg-white">
            <div class="card-title mb-0">
              <h4 class="rgenda-text-dark-blue mb-0">{{ resultTitle }}
                <div class="float-right">
                  <button type="button" class="btn btn-tool" data-toggle="collapse" data-target="#collapseResultUI"
                  aria-expanded="true" aria-controls="collapseResultUI"><i class="fas fa-minus"></i></button>
                </div>
              </h4>
            </div>
          </div>
          <div id="collapseResultUI" class="collapse show" aria-labelledby="headingResultUI" data-parent="#accordionResultUI">
            <div class="card-body">

              <!-- Profile -->
              <profile id="profile" class="mb-4"
              :userId="userId"></profile>
              <!-- \Profile -->

              <!-- Working day -->
              <working-day id="working-day" class="mb-4"
              :schedule="schedule"></working-day>
              <!-- \Working day -->

              <!-- Attendance log -->
              <attendance-log id="attendance-log" class="mb-4"
              :schedule="schedule"
              :time-adjustments="timeAdjustments">
              </attendance-log>
              <!-- \Attendance log -->

              <!-- Shifts -->
              <div id="calendar" class="mb-4">
                <div class="d-flex">
                  <div class="rounded d-flex symbol-square">
                  </div>
                  <div class="col mb-2 pl-2">
                    <h6>歷史班表</h6>
                  </div>
                </div>

              </div>
              <!-- \Shifts -->
            </div>
          </div>
        </div>
      </div>
      <!-- \Result UI -->
    </div>
  </div>
</div>
</template>

<script>
import popup from 'common/popup';
import {
  httpRep,
  nl2br,
} from 'common/helpers';
import dayjs from 'dayjs';
import VueMonthlyPicker from 'vue-monthly-picker';
import FullCalendar from '@fullcalendar/vue';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';
import WorkingDay from './WorkingDay.vue';
import AttendanceLog from './AttendanceLog.vue';
import Profile from './Profile.vue';

export default {
  components: {
    VueMonthlyPicker,
    FullCalendar,
    Profile,
    WorkingDay,
    AttendanceLog,
  },
  props: {
    locale: {
      type: String,
      default: 'en',
    },
    firstDay: {
      type: Number,
      default: 1,
    },
    csrfToken: {
      type: String,
      default: '',
    },
    currentUserId: {
      type: Number,
      default: 0,
    },
    currentUserRole: {
      type: String,
      default: '',
    },
  },
  data() {
    return {
      selectedType: 1,
      selectedYearMonth: '',
      maxYearMonth: '',
      queryString: '',
      userId: 0,
      queryMonth: '',
      showResult: false,
      resultTitle: '',

      // common parameters
      schedule: [],
      timeAdjustments: [],
    };
  },
  methods: {
    $_profile_validation() {
      let errMsg = [];
      let valid = true;
      if ('' === this.queryMonth) {
        valid = false;
        errMsg.push('查詢年月欄位格式錯誤');
      }

      return [valid, errMsg];
    },
    $_profile_setUserId(userId) {
      if (this.isManager()) {
        this.userId = userId;
      } else {
        this.userId = this.currentUserId;
      }
    },
    $_profile_resultTitle() {
      if ('' !== this.queryMonth) {
        let year = this.queryMonth.substring(0, 4);
        let month = Number(this.queryMonth.substring(5));

        this.resultTitle = `${year} 年 ${month} 月份 出勤紀錄`;
      } else {
        this.resultTitle = '--';
      }
    },
    query() {
      const self = this;
      let [bool, errMsg] = this.$_profile_validation();
      if (!bool) {
        popup.error({
          title: '驗證錯誤',
          html: httpRep.messageJoin(errMsg),
        });
        return false;
      }

      self.$_profile_setUserId(0);
      self.generateQueryString();

      const resultUrl = `/api/results/${self.queryString}`;
      const timeAdjustmentUrl = `/api/time-adjustment/${self.queryString}`;

      popup.loading({
        title: '處理中...',
      });

      Promise.all([
        self.$httpClient.get(resultUrl),
        self.$httpClient.get(timeAdjustmentUrl),
      ])
      .then((responses) => {
        popup.close();

        if (responses[0].data.length > 1) {
          self.schedule = responses[0].data;
        } else {
          self.schedule = [];
        }
        if (responses[1].data.length > 1) {
          self.timeAdjustments = responses[1].data;
        } else {
          self.timeAdjustments = [];
        }

        self.$_profile_resultTitle();
        self.showResult = true;
      })
      .catch(function (error) {
        // handle error
        popup.error({
          title: error.title,
          html: httpRep.messageJoin(error.message),
        });
        console.log(error);
      });;
    },
    generateQueryString() {
      let startDate = dayjs(this.queryMonth, 'YYYY-MM').startOf('month').format("YYYY-MM-DD");
      let endDate = dayjs(this.queryMonth, 'YYYY-MM').endOf('month').format("YYYY-MM-DD");
      this.queryString = `?uid=${this.userId}&start=${startDate}&end=${endDate}`;
    },
    isManager() {
      return ['admin', 'manager'].includes(this.currentUserRole);
    },
  },
  mounted() {
    // this.$_profile_setUserId(0);

    this.maxYearMonth = dayjs().subtract(1, 'month').format('YYYY-MM').toString();
  },
  computed: {
  },
  watch: {
    selectedYearMonth(newVal) {
      this.queryMonth = newVal ? dayjs(newVal).format('YYYY-MM') : '';
    }
  },
}
</script>

<style scoped lang="scss">
.card-header .btn-tool {
  padding: 0;
}

::v-deep .symbol-square {
  width: 1.5rem;
  height: 1.5rem;
  line-height: 1.5rem;
  background-color: #84c0e9;
}
</style>
