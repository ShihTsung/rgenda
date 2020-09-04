<template>
  <div class="row no-gutters">
    <div class="offset-1 col-5">
      <div class="card mx-1">
        <div class="card-header text-center">
          <button class="btn" id="toggle-btn">
            <i class="fa fa-bars"></i>
          </button>
          班表分析
          <span class="unit">單位：日</span>
        </div>
        <div class="card-body DashCollapse">
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
        </div>
      </div>
    </div>

    <div class="col-5">
      <div class="card mx-1">
        <div class="card-header text-center">
          出勤分析
          <span class="unit">單位：時</span>
        </div>
        <div class="card-body DashCollapse">
          <div class="left">
            <div class='data'>
              <div class="label">排班</div>
              <div class="nums">1</div>
            </div>
            <div class='data'>
              <div class="label">加班</div>
              <div class="nums">1</div>
            </div>
            <div class='data'>
              <div class="label">On call</div>
              <div class="nums">1</div>
            </div>
            <div class='data'>
              <div class="label">減班</div>
              <div class="nums">1</div>
            </div>
            <div class='data'>
              <div class="label">差額</div>
              <div class="nums">1</div>
            </div>
          </div>
          <div class="right">
            <canvas id='chart2'>
            </canvas>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import BarChart from '../partial/BarChart.vue';
import moment from 'moment';

export default {
  data() {
    return {
      dates: {},
      shiftDataCollection: null,
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
    getDatesData() {
      let self = this;

      const url = '/api/results/?mode=personal&start='
        + moment().startOf('month').format('YYYY-MM-DD')
        + '&end='
        + moment().endOf('month').format('YYYY-MM-DD');
      this.$httpClient.get(url).then(response => {
        const data = response.data;
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
        data.forEach(d => {
          if (self.$isWorkShift(d.shift.shift_type)) {
            dates.work.number++;

            if (self.$getShiftTypeValue('VALUE_DAY_SHIFT') == d.shift.shift_type) {
              shiftStat.dayShift++;
            } else if (self.$getShiftTypeValue('VALUE_NIGHT_SHIFT') == d.shift.shift_type) {
              shiftStat.nightShift++;
            } else if (self.$getShiftTypeValue('VALUE_GRAVEYARD_SHIFT') == d.shift.shift_type) {
              shiftStat.graveyardShift++;
            } else if (self.$getShiftTypeValue('VALUE_ON_CALL') == d.shift.shift_type) {
              shiftStat.onCall++;
            }
          } else {
            let leaveItem = self.$getPromiseLeaveItemByText(d.shift.name);
            if (leaveItem) {
              if (self.$getPromiseLeaveItemValue('ITEM_REST_LEAVE') === leaveItem.id) {
                dates.restLeave.number++;
              } else if (self.$getPromiseLeaveItemValue('ITEM_OFFICIAL_HOLIDAY') === leaveItem.id) {
                dates.officialHoliday.number++;
              } else if (self.$getPromiseLeaveItemValue('ITEM_NATIONAL_HOLIDAY') === leaveItem.id) {
                dates.nationalHoliday.number++;
              } else if (self.$getPromiseLeaveItemValue('ITEM_ANNUAL_LEAVE') === leaveItem.id) {
                dates.annualLeave.number++;
              }

              if (self.$getPromiseLeaveItemValue('ITEM_EMPTY_SHIFT') === leaveItem.id) {
                shiftStat.emptyShift++;
              }
            }
          }
        });

        self.dates = dates;
        self.shiftDataCollection = {
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
            backgroundColor: '#37419A',
            borderColor: '#37419A',
            borderWidth: 1
          }]
        };
      });
    },
  },
  mounted() {
    this.getDatesData();
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
    width: 65%;
    height: 100%;
    margin: 0;
    overflow: hidden;
    display: inline-flex;
    max-width: 25rem;
    position: relative;
  }

  .left {
    width: 30%;
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
</style>
