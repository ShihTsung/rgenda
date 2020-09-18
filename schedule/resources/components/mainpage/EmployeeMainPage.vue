<template>
  <div class="row no-gutters">
    <div class="col-6">
      <div class="card mx-1">
        <div class="card-header text-center">
          <button class="btn" id="toggle-btn" @click="show=!show">
            <i class="fa fa-bars"></i>
          </button>
          班表分析
          <span class="unit">單位：日</span>
        </div>
        <div class="card-body DashCollapse" v-show="show">
          <template v-if="dates">
            <div class="left">
              <div class='data' v-for="(date, index) in dates" :key="index">
                <div class="label">{{date.label}}</div>
                <div class="nums">{{date.number}}</div>
              </div>
            </div>
            <div class="right">
              <bar-chart
              v-if="shiftDataCollection"
              :styles="{width: '100%', position: 'relative'}"
              :chart-data="shiftDataCollection"
              :options="chartOptions"></bar-chart>
            </div>
          </template>
          <div v-else class="mx-auto h5 no-data">
            無資料
          </div>
        </div>
      </div>
    </div>

    <div class="col-6">
      <div class="card mx-1">
        <div class="card-header text-center">
          出勤分析
          <span class="unit">單位：時</span>
        </div>
        <div class="card-body DashCollapse" v-show="show">
          <template v-if="hours">
            <div class="left">
              <div class='data' v-for="(hour, index) in hours" :key="index">
                <div class="label">{{hour.label}}</div>
                <div class="nums">{{hour.number}}</div>
              </div>
            </div>
            <div class="right">
              <bar-chart
              v-if="hourDataCollection"
              :styles="{width: '100%', position: 'relative'}"
              :chart-data="hourDataCollection"
              :options="chartOptions"></bar-chart>
            </div>
          </template>
          <div v-else class="mx-auto h5 no-data">
            無資料
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import BarChart from '../partial/BarChart.vue';
import moment from 'moment';
import { shiftColor, adjustColor } from 'src/constants/color.js';

export default {
  data() {
    return {
      dayHours: 8,
      results: [],
      timeAdjustments: [],
      user: null,
      dates: {},
      shiftDataCollection: null,
      hours: {},
      show: true,
      hourDataCollection: null,
      chartOptions: {
        scales: {
          yAxes: [{
            ticks: {
              beginAtZero: true
            },
            gridLines: {
              offsetGridLines: false,
              display: false
            }
          }],
          xAxes: [{
            ticks: {
              beginAtZero: true
            },
            gridLines: {
              offsetGridLines: false,
            }
          }]
        },
        legend: {
          display: false,
        },
        maintainAspectRatio: false,
        responsive: true,
      },
    }
  },
  methods: {
    init() {
      let self = this;

      const queryString = '?mode=personal&start='
        + moment().startOf('month').format('YYYY-MM-DD')
        + '&end='
        + moment().endOf('month').format('YYYY-MM-DD');
      const resultUrl = '/api/results/' + queryString;
      const timeAdjustmentUrl = '/api/time-adjustment/' + queryString;
      Promise.all([
        this.$httpClient.get(resultUrl),
        this.$httpClient.get(timeAdjustmentUrl),
        this.$httpClient.get('/api/users/curr/'),
      ]).then(responses => {
        if (responses[0].data) {
          self.results = responses[0].data;
        }
        if (responses[1].data) {
          self.timeAdjustments = responses[1].data;
        }
        if (responses[2].data) {
          self.user = responses[2].data;
        }

        self.getDatesData();
        self.getHoursData();
      });
    },
    getDatesData() {
      let dates = {
        work: {
          label: '工作日',
          number: 0
        },
        restLeave: {
          label: '休息日',
          number: 0
        },
        officialHoliday: {
          label: '例假日',
          number: 0
        },
        nationalHoliday: {
          label: '國定假日',
          number: 0
        },
        annualLeave: {
          label: '特休',
          number: 0
        }
      };
      let shiftStat = {
        dayShift: 0,
        nightShift: 0,
        graveyardShift: 0,
        onCall: 0,
        emptyShift: 0,
      };

      this.results.forEach(result => {
        if (this.$isWorkShift(result.shift.shift_type)) {
          dates.work.number++;

          if (this.$getShiftTypeValue('VALUE_DAY_SHIFT') == result.shift.shift_type) {
            shiftStat.dayShift++;
          } else if (this.$getShiftTypeValue('VALUE_NIGHT_SHIFT') == result.shift.shift_type) {
            shiftStat.nightShift++;
          } else if (this.$getShiftTypeValue('VALUE_GRAVEYARD_SHIFT') == result.shift.shift_type) {
            shiftStat.graveyardShift++;
          } else if (this.$getShiftTypeValue('VALUE_ON_CALL') == result.shift.shift_type) {
            shiftStat.onCall++;
          }
        } else {
          let leaveItem = this.$getPromiseLeaveItemByText(result.shift.name);
          if (leaveItem) {
            if (this.$getPromiseLeaveItemValue('ITEM_REST_LEAVE') === leaveItem.id) {
              dates.restLeave.number++;
            } else if (this.$getPromiseLeaveItemValue('ITEM_OFFICIAL_HOLIDAY') === leaveItem.id) {
              dates.officialHoliday.number++;
            } else if (this.$getPromiseLeaveItemValue('ITEM_NATIONAL_HOLIDAY') === leaveItem.id) {
              dates.nationalHoliday.number++;
            } else if (this.$getPromiseLeaveItemValue('ITEM_ANNUAL_LEAVE') === leaveItem.id) {
              dates.annualLeave.number++;
            }

            if (this.$getPromiseLeaveItemValue('ITEM_EMPTY_SHIFT') === leaveItem.id) {
              shiftStat.emptyShift++;
            }
          }
        }
      });

      this.dates = dates;
      this.shiftDataCollection = {
        labels: ['白班', '小夜', '大夜', 'On call', '空班'],
        datasets: [{
          barThickness: 30,
          data: [
            shiftStat.dayShift,
            shiftStat.nightShift,
            shiftStat.graveyardShift,
            shiftStat.onCall,
            shiftStat.emptyShift,
          ],
          backgroundColor: [
            shiftColor[this.$getShiftTypeValue('VALUE_DAY_SHIFT')],
            shiftColor[this.$getShiftTypeValue('VALUE_NIGHT_SHIFT')],
            shiftColor[this.$getShiftTypeValue('VALUE_GRAVEYARD_SHIFT')],
            shiftColor[this.$getShiftTypeValue('VALUE_ON_CALL')],
            shiftColor.default,
          ],
          borderColor: 'transparent',
          borderWidth: 1
        }]
      };
    },
    getHoursData() {
      // 排班 = 本月的(排班時數+加班時數「休息日出勤」+公假時數)
      // on call = 累計至當日(天換時)
      // 加班 = 出缺勤補登加班
      // 減班 = 出缺勤補登「機構減班」
      // 當月差額 = 排班時數 + 加班時數 - 重複計算的加班時數「休息日出勤」 - 減班時數 + 不出勤時數(天數*日出勤時數) - 當月天數*日出勤時數
      // 出勤 = 累計至當日的(排班時數+加班時數-減班時數+公假時數)
      // 公假 = 累計至當日的公假(天換時)
      // 自假 = 累計至當日的 有薪假 + 無薪假(天換時) + 出缺勤補登「員工自假」
      let hours = {
        total: {
          label: '排班',
          number: 0
        },
        onCall: {
          label: 'On call',
          number: 0
        },
        overtime: {
          label: '加班',
          number: 0
        },
        reduceHour: {
          label: '減班',
          number: 0
        },
        diffHour: {
          label: '差額',
          number: 0
        }
      };
      let hourStat = {
        work: 0,
        officialHoliday: 0,
        leave: 0
      };

      this.results.forEach(result => {
        let isSameOrBefore = moment(result.date).isSameOrBefore(moment(), 'day');

        if (this.$isWorkShift(result.shift.shift_type)) {
          hours.total.number += result.shift.work_hours;
          if (isSameOrBefore) {
            hourStat.work += result.shift.work_hours;
            if (this.$getShiftTypeValue('VALUE_ON_CALL') == result.shift.shift_type) {
              hours.onCall.number += this.dayHours;
            }
          }
        } else {
          if (this.$getShiftTypeValue('VALUE_OFFICIAL_LEAVE') === result.shift.shift_type) {
            hours.total.number += this.dayHours;
            if (isSameOrBefore) {
              hourStat.officialHoliday += this.dayHours;
            }
          } else {
            if (isSameOrBefore) {
              hourStat.leave += this.dayHours;
            }
          }
        }
      });

      this.timeAdjustments.forEach(adjustment => {
        if (adjustment.user === this.user.id) {
          let isSameOrBefore = moment(adjustment.date).isSameOrBefore(moment(), 'day');

          if (adjustment.adjustment_type === 0) {
            if (this.$getTimeAdjustmentItemValue('ITEM_OFF_DAY_ATTENDANCE') === adjustment.adjustment_item) {
              hours.total.number += adjustment.hours;
            }
            if (isSameOrBefore) {
              hours.overtime.number += adjustment.hours;
            }
          } else {
            hours.total.number -= adjustment.hours;
            if (isSameOrBefore) {
              if (this.$getTimeAdjustmentItemValue('ITEM_INSTITUTION_REDUCE_CLASS') === adjustment.adjustment_item) {
                hours.reduceHour.number += adjustment.hours;
              } else if (this.$getTimeAdjustmentItemValue('ITEM_EMPLOYEE_LEAVE') === adjustment.adjustment_item) {
                hourStat.leave += adjustment.hours;
              }
            }
          }
        }
      });

      // 不出勤天數，非工作日 且 非公假
      let offDays = this.results.filter(result => {
        return (!this.$isWorkShift(result.shift.shift_type))
          && this.$getShiftTypeValue('VALUE_OFFICIAL_LEAVE') !== result.shift.shift_type
      }).length;
      // 休息日出勤時數
      let offDateAttendantHours = this.timeAdjustments.reduce((accumulator, currentValue) => {
        if (currentValue.user === this.user.id && this.$getTimeAdjustmentItemValue('ITEM_OFF_DAY_ATTENDANCE') === currentValue.adjustment_item) {
          return accumulator + currentValue.hours;
        }
        return accumulator;
      }, 0)
      hours.diffHour.number = hours.total.number
        + hours.overtime.number
        - offDateAttendantHours
        - hours.reduceHour.number
        + offDays * this.dayHours
        - moment().daysInMonth() * this.dayHours;
      this.hours = hours;
      this.hourDataCollection = {
        labels: ['排班', '出勤', '公假', '自假'],
        datasets: [{
          barThickness: 30,
          data: [
            hours.total.number,
            hourStat.work,
            hourStat.officialHoliday,
            hourStat.leave,
          ],
          backgroundColor: [
            shiftColor.default,
            '#37419a',
            '#37419a',
            '#37419a'
          ],
          borderColor: 'transparent',
          borderWidth: 1
        }]
      };
    },
  },
  mounted() {
    this.init();
  },
  components: {
    BarChart
  }
}
</script>
<style lang="css" scoped>
  .row {
    width: 100%;
  }

  .DashCollapse {
    height: 20rem;
    display: inline-flex;
    flex-direction: row;
    flex-wrap: nowrap;
  }

  .DashCollapse {
    height: 20rem;
    display: inline-flex;
    flex-direction: row;
    flex-wrap: nowrap;
  }

  .card-header {
    font-size: 1.6rem;
  }

  .card-header>.btn {
    margin: 0;
    float: left;
  }

  .unit {
    float: right;
    font-size: 14px;
  }

  .card-header .fa-bars::before {
    color: #666;
  }

  .right {
    width: 78%;
    height: 100%;
    margin: 0;
    overflow: hidden;
    display: inline-flex;
    max-width: 25rem;
    position: relative;
  }

  .left {
    width: 20%;
    height: 100%;
    min-width: 10rem;
    margin: 0;
    display: inline-flex;
    flex-direction: column;
    justify-content: space-around;
    font-size: 1rem;
  }

  .data {
    display: flex;
  }

  .label {
    width: 60%;
  }

  .no-data {
    display: flex;
    justify-content: center;
    align-items: center;
  }
</style>
