<template>
  <div id="results" v-cloak>
    <loading v-show="showLoading" :text="text"></loading>
   <div id="top-info">
      <div class="time">
        <h2 class="year">{{year}}年</h2>
        <h2 class="month">&nbsp;{{month}}月</h2>
      </div>

      <div class="bt-group">
        <div class="add-sub-wrapper" @click="changeMonth($event)">
          <div id="prev" data-tooltip="tooltip" title="上個月">
            <svg
              class="icon-color left"
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
            >
              <path d="M16.67 0l2.83 2.829-9.339 9.175 9.339 9.167-2.83 2.829-12.17-11.996z" />
            </svg>
          </div>
          <div class="icon-bts" id="current" data-tooltip="tooltip" title="回到次月">
            <svg
              class="icon-color"
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
            >
              <path
                d="M20 19h-4v-4h4v4zm-6-10h-4v4h4v-4zm6 0h-4v4h4v-4zm-12 6h-4v4h4v-4zm16-14v22h-24v-22h24zm-2 6h-20v14h20v-14zm-8 8h-4v4h4v-4zm-6-6h-4v4h4v-4z"
              />
            </svg>
          </div>
          <div id="next" data-tooltip="tooltip" title="下個月">
            <svg
              class="icon-color right"
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
            >
              <path d="M7.33 24l-2.83-2.829 9.339-9.175-9.339-9.167 2.83-2.829 12.17 11.996z" />
            </svg>
          </div>
        </div>
      </div>
    </div>

    <div class="calendar">
      <table
        class="master-schedule-table"
        border="1"
        cellspacing="0"
        bordercolor="#b2b2b2"
      >
        <result-table-head :year="year" :month="month" :getDays="getDays"></result-table-head>
        <tbody style="overflow: scroll">
          <tr v-for="(u, id) in userData" :key="id">
            <td class="white-background">{{ u.eid }}</td>
            <td class="white-background">N{{ u.level == 5 ? 'n' : u.level }}</td>
            <td class="white-background">
              <div style="width: 5rem">
                <div class="identity-circle" :class="whichCircle(u.type_of_user)"></div>
                {{ u.full_name }}
              </div>
            </td>
            <td class="gray-background grid-width">{{ lastMonthData[u.id] }}</td>
            <user-shift-cell
              v-for="(dd, d3) in getDays"
              :key="`3${d3}`"
              :isReady="isReady"
              :isPast="isPast(dd)"
              :whichBorder="whichBorder(getUserShift(u.id, dd))"
              :shiftInfo="getUserShift(u.id, dd)"
              :adjustmentStr="getAdjustmentString(u.id, dd)"
              :adjustmentRemark="getAdjustmentRemark(u.id, dd)"
              :triangle="userReserve(u.id, month, dd)"
              :isCheck="isCheck"
              :text="text"
            ></user-shift-cell>
            <td class="gray-background">
              <input
                class="remark-grid"
                type="text"
                :value="findRemark(u.id)"
                @blur="getRemark($event, u.id)"
                @keyup.13="$event.target.blur"
                v-show="isEdit"
              />
              <div v-show="!isEdit" class="remark-grid">{{ findRemark(u.id) }}</div>
            </td>
            <td class="white-background">{{ getTotalShiftHour(u.id) }}</td>
            <td class="gray-background">{{ workhr(u.id, date, 1) }}</td>
            <td class="white-background">{{ workhr(u.id, date, 3) }}</td>
            <td class="white-background">{{ workhr(u.id, date, 4) }}</td>
            <td class="white-background">{{ workhr(u.id, date, 2) }}</td>
            <td class="gray-background">{{ offHours(u.id, 4) }}</td>
            <td class="white-background">{{ offHours(u.id, 1) }}</td>
            <td class="white-background">{{ offHours(u.id, 5) }}</td>
            <td class="white-background">{{ offHours(u.id, 2) }}</td>
            <td class="white-background">{{ offHours(u.id, 3) }}</td>
            <td class="gray-background">{{ getDiffHour(u.id) }}</td>
            <td class="white-background">-</td>
            <td class="white-background">-</td>
          </tr>
          <tr class="gray-background">
            <td colspan="4" rowspan="2">排班統計</td>
            <td class="grid-width" v-for="(day, d4) in getDays" :key="d4">
              <div>{{ day }}</div>
            </td>
            <td rowspan="2"></td>
            <td colspan="13" rowspan="2">標誌說明</td>
          </tr>
          <tr class="gray-background">
            <td v-for="(d, d7) in getDays" :key="`7${d7}`" class="grid-width">
              <div>
                {{ getWeekday(d) }}
              </div>
            </td>
          </tr>
          <shift-statistics
            :isReady="isReady"
            :isEdit="isEdit"
            shiftName="白班"
            shiftKey="D"
            :getDays="getDays"
            :demandList="demandList"
            rs="rs1"
            :remarkContent="getRemarkSquare(0)"
          ></shift-statistics>
          <shift-statistics
            :isReady="isReady"
            :isEdit="isEdit"
            shiftName="小夜班"
            shiftKey="E"
            :getDays="getDays"
            :demandList="demandList"
            rs="rs2"
            :remarkContent="getRemarkSquare(1)"
          ></shift-statistics>
          <shift-statistics
            :isReady="isReady"
            :isEdit="isEdit"
            shiftName="大夜班"
            shiftKey="N"
            :getDays="getDays"
            :demandList="demandList"
            rs="rs3"
            :remarkContent="getRemarkSquare(2)"
          ></shift-statistics>
        </tbody>
      </table>
    </div>
  </div>
</template>
<script>
import moment from "moment";
import "moment/locale/zh-tw";
import Loading from "./Loading.vue";
import ResultTableHead from "./ResultTableHead.vue";
import UserShiftCell from "./UserShiftCell.vue";
import ShiftStatistics from "./ShiftStatistics.vue";


moment.locale("zh-tw");
export default {
  components: {
    Loading,
    ResultTableHead,
    UserShiftCell,
    ShiftStatistics,
  },

  props: {
    csrfToken: {
      type: String,
      default: "",
    },
  },

  data() {
    return {
      user: {},
      year: moment().year(),
      month: moment().add(1, "months").month() + 1,
      date: moment().date(),
      workDayHours: 8,
      userData: [],
      preResultData: [],
      adjustHr: [],
      lastMonthData: [],
      userRemarkData: [],
      userRemarks: [],
      demandData: [],
      remarkSquareData: [],
      preResultRemarkData: [],
      remarkSquare: [],
      shiftData: [],
      resultRS: [],
      changeInfo: {},
      isReady: false,
      isEdit: false,
      rsShow: false,
      isConfirm: false, //確認後控制正在重算載入畫面的變數
      couldRecalculate: false,
      rsClass: "",
      follower: {},
      stationData: [],
      shiftOfCurrentMonth: {},
      changedResult: [],
      rs: "",
      reserveData: [],
      checkResultData: [],
      isCheck: false,
      text: "載入中...",
      showLoading: false,
      publishStatus: 0,
      isPass: false,
      isSave: false,
      demandList: [],
      promiseData: [],
    };
  },

  mounted() {
    this.$httpClient.get("/api/users/curr/").then((res) => {
      this.user = res.data;
      Promise.all([
        this.getUserData(),
        this.getPreResults(),
        this.getLastMonthData(),
        this.getAdjustment(),
        this.getTotalPerDayData(),
      ]).then(() => {
        this.getDemandList();
      });
      this.getUserRemark();
      this.getRemarkSquareData();
      this.getPreResultRemarkData();
      this.getShiftData();
      this.getStationData();
      this.getReserveData();
      this.getPromiseData();
    })
  },

  computed: {
    //計算該年該月的天數
    getDays() {
      return moment([this.year, this.month - 1, 1]).daysInMonth();
    },

    stationPicker() {
      return this.stationData.filter((i) => {
        return i.name.indexOf("假") === -1;
      });
    },
  },

  methods: {
    //-------------------取得api-----------------------

    //取得User的資料
    getUserData() {
      return fetch("/api/user-resource")
        .then((res) => {
          return res.json();
        })
        .then((data) => {
          this.userData = data;
        })
        .catch((err) => {
          console.log(err);
        });
    },

    //取得Pre-result的資料
    getPreResults() {
      //處理懶加載畫面的變數設置
      this.isReady = false;
      this.showLoading = true;

      return fetch(
        `/api/results/?start=${this.year}-${this.month}-01&end=${this.year}-${this.month}-${this.getDays}`
      )
        .then((res) => {
          return res.json();
        })
        .then((data) => {
          this.preResultData = data;
          //處理懶加載畫面的變數設置
          let processedShifts = {}; // index by user id
          if (this.preResultData.length != 0) {
            this.preResultData.forEach((i) => {
              if (moment(i.date).month() + 1 === this.month) {
                if (!processedShifts[i.user]) {
                  processedShifts[i.user] = {};
                }
                let date = moment(i.date).date();

                //紀錄檢核後有問題的班別是否修改的變數設置
                i.isModified = false;
                processedShifts[i.user][date] = i;
              }
            });
            this.shiftOfCurrentMonth = processedShifts;
            this.isReady = true;

          }
            this.showLoading = false;
            this.shiftOfCurrentMonth = processedShifts;
        })
        .catch((err) => {
          console.log(err);
        });
    },

    //取得前一個月最後幾天排班資料
    getLastMonthData() {
      return fetch(`/api/last-month-continue?month_head=${this.year}-${this.month}-01`)
        .then((res) => {
          return res.json();
        })
        .then((data) => {
          this.lastMonthData = data;
        })
        .catch((err) => {
          console.log(err);
        });
    },

    //取得加減班的資料
    getAdjustment() {
      return fetch(
        `/api/time-adjustment/?start=${this.year}-${this.month}-01&end=${this.year}-${this.month}-${this.getDays}`
      )
        .then((res) => {
          return res.json();
        })
        .then((data) => {
          this.adjustHr = data;
        })
        .catch((err) => {
          console.log(err);
        });
    },

    //取得備註的資料
    getUserRemark() {
      fetch("/api/user-remarks/")
        .then((res) => {
          return res.json();
        })
        .then((data) => {
          this.userRemarkData = data;
        })
        .catch((err) => {
          console.log(err);
        });
    },

    //取得當月人力配置的預設值跟實際值的資料
    getTotalPerDayData() {
      return fetch(
        `/api/total-per-day/?start=${this.year}-${this.month}-01&end=${this.year}-${this.month}-${this.getDays}`
      )
        .then((res) => {
          return res.json();
        })
        .then((data) => {
          this.demandData = data;
        })
        .catch((err) => {
          console.log(err);
        });
    },

    //取得標誌的內容
    getRemarkSquareData() {
      fetch("/api/remark-squares/")
        .then((res) => {
          return res.json();
        })
        .then((data) => {
          this.remarkSquareData = data;
          for (let i = 0; i < 3; ++i) {
            if (!this.remarkSquareData[i] || Object.keys(this.remarkSquareData[i]).length === 0) {
              let data = {
                content: '',
                department: this.user.department.id,
              };
              let config = {
                headers: {
                  "X-CSRFToken": `${this.csrfToken}`,
                  "content-type": "application/json",
                },
              };
              this.$httpClient.post('/api/remark-squares/', data, config)
                .then(res => {
                  this.remarkSquareData.push(res.data);
                });
            }
          }
        })
        .catch((err) => {
          console.log(err);
        });
    },

    //取得每個使用者每天的班別是否有標誌資料
    getPreResultRemarkData() {
      fetch("/api/preresult-remarks/")
        .then((res) => {
          return res.json();
        })
        .then((data) => {
          this.preResultRemarkData = data;
        })
        .catch((err) => {
          console.log(err);
        });
    },

    //取得班別資料
    getShiftData() {
      fetch("/api/shifts/")
        .then((res) => {
          return res.json();
        })
        .then((data) => {
          this.shiftData = data;
        })
        .catch((err) => {
          console.log(err);
        });
    },

    //取得工作站資料
    getStationData() {
      let self = this;
      this.$httpClient
        .get("/api/stations/?department="+this.user.department.id)
        .then((response) => {
          self.stationData = response.data;
        })
        .catch((err) => {
          console.log(err);
        });
    },

    getReserveData() {
      let self = this;
      this.$httpClient
        .get("/api/reservations/")
        .then((res) => {
          self.reserveData = res.data;
        })
        .catch((err) => {
          console.log(err);
        });
    },

    //取得檢核的資料
    getCheckResultData() {
      if(this.isSave) {
        this.showLoading = true;
        this.text = "檢核中...";

        fetch(
          `/api/checkresult/?date=${this.year}-${this.month}-01&department=${this.user.department.id}`
        )
          .then((res) => {
            return res.json();
          })
          .then((data) => {
            this.checkResultData = data;
            this.isCheck = true;
            this.showLoading = false;
            this.text = "載入中...";
            this.checkResultData.length === 0
              ? $("#checkPass").modal("show")
              : $("#checkPass").modal("hide");
          })
          .then(() => {
            this.isSave = false;
          })
          .catch((err) => {
            console.log(err);
          });
      }
    },

    getPromiseData() {
      this.$httpClient.get(`/api/promises/?start=${this.year}-${this.month}-01&end=${this.year}-${this.month}-${this.getDays}`)
        .then((res) => {
          this.promiseData = res.data;
        })
        .catch((err) => {
          console.error(err);
        })
    },
    //----------------------------------------------------

    //-------------------各個function----------------------

    getWeekday(d) {
      return moment([this.year, this.month - 1, d]).format('dd');
    },

    // 改變當前月份
    changeMonth(ev) {
      let date = moment([this.year, this.month - 1, 1]);
      switch (ev.target.id) {
        case "prev":
          this.isEdit = false;
          date.subtract(1, "months");
          this.year = date.year();
          this.month = date.month() + 1;
          break;
        case "current":
          this.isEdit = false;
          this.year = moment().add(1, "months").year();
          this.month = moment().add(1, "months").month() + 1;
          break;
        case "next":
          this.isEdit = false;
          date.add(1, "months");
          this.year = date.year();
          this.month = date.month() + 1;
      }
    },

    //計算該日期是否為今天以前
    isPast(d) {
      if (moment([this.year, this.month - 1, d]).isBefore(moment(), "date")) {
        return "gray-background";
      } else {
        if (this.isEdit) {
          return "couldEdit hoverEvent";
        }
        return "hoverEvent";
      }
    },

    //判斷該職級的樣式
    whichCircle(index) {
      switch (index) {
        case 0: //資淺
          return "junior";
        case 1: //資深
          return "senior";
        case 2: //行政職
          return "administrative";
        case 3: //新進人員
          return "new-in";
        case 4: //兼職
          return "administrative";
        case 5: //實習生
          return "new-in";
      }
    },

    //取得該user當天是否有加減班的資料
    getAdjustmentString(userId, d) {
      let date = moment([this.year, this.month - 1, d]);
      let adjustment = this.adjustHr.find((item) => {
        return item.user == userId && date.isSame(moment(item.date), "date");
      });
      if (adjustment != undefined) {
        if (adjustment.adjustment_type == 0) {
          return "+" + adjustment.hours;
        } else if (adjustment.adjustment_type == 1) {
          return "-" + adjustment.hours;
        }
      }
    },

    getAdjustmentRemark(userId, d) {
      let adjustment = this.adjustHr.find((item) => {
        return (
          item.user === userId &&
          parseInt(item.date.split("-")[1]) === this.month &&
          parseInt(item.date.split("-")[2]) === d
        );
      });
      if (
        adjustment &&
        adjustment.remark &&
        adjustment.adjustment_item ===
          this.$getTimeAdjustmentItemValue("ITEM_OFF_DAY_ATTENDANCE")
      ) {
        // 若為休息日出勤，則顯示備註
        return adjustment.remark;
      }
      return "";
    },

    // 當月該使用者是否有備註
    findRemark(id) {
      let remark = this.userRemarkData.find((i) => {
        if (i.user == id) {
          return i.month == this.month;
        }
      });

      if (remark) {
        return remark.content;
      }
    },

    //將儲存之後要送往user-remarks api的資料先暫存在remark的陣列中
    getRemark(ev, id) {
      let data = {
        content: ev.target.value.toString(),
        user: id,
        month: this.month,
      };

      this.userRemarks.push(data);
    },

    getTotalShiftHour(userId) {
      if (!this.isReady) {
        return -1;
      }

      // 排班 = user 所有班別時數總和 + 公假時數 + 休息日出勤
      // 班別時數總和
      let totalHour = 0;
      // 公假時數
      let officialLeaveHour = 0;
      for (let day = 1; day <= this.getDays; ++day) {
        if (
          this.shiftOfCurrentMonth[userId] &&
          this.shiftOfCurrentMonth[userId][day]
        ) {
          let i = this.shiftOfCurrentMonth[userId][day];
          if (i.shift_type === "公") {
            officialLeaveHour +=
              i.shift.work_hours === 0 ? this.workDayHours : i.shift.work_hours;
          } else {
            totalHour += i.shift.work_hours;
          }
        }
      }
      // 休息日出勤時數
      let offDateAttendantHour = 0;
      this.adjustHr.forEach((i) => {
        if (
          i.user === userId &&
          parseInt(i.date.split("-")[1]) === this.month &&
          this.$getTimeAdjustmentItemValue("ITEM_OFF_DAY_ATTENDANCE") ===
            i.adjustment_item
        ) {
          offDateAttendantHour += i.hours;
        }
      });
      return totalHour + officialLeaveHour + offDateAttendantHour;
    },

    getDiffHour(userId) {
      if (!this.isReady) {
        return -1;
      }

      // 當月差額 = user 所有班別時數總和 + 加班時數 - 減班時數 + 不出勤時數 - 當月時數
      // 班別時數總和
      let totalHour = 0;
      for (let day = 1; day <= this.getDays; ++day) {
        if (
          this.shiftOfCurrentMonth[userId] &&
          this.shiftOfCurrentMonth[userId][day]
        ) {
          let i = this.shiftOfCurrentMonth[userId][day];
          totalHour += i.shift.work_hours;
        }
      }
      let addHour = 0;
      let subHour = 0;
      this.adjustHr.forEach((i) => {
        if (
          i.user === userId &&
          parseInt(i.date.split("-")[1]) === this.month
        ) {
          if (i.adjustment_type === 0) {
            addHour += i.hours;
          } else if (i.adjustment_type === 1) {
            subHour += i.hours;
          }
        }
      });

      // 不出勤日
      let offDays = this.offHours(userId, 4);

      return (
        totalHour +
        addHour -
        subHour +
        offDays * this.workDayHours -
        this.getDays * this.workDayHours
      );
    },

    //排班時數、出勤時數、當月差額計算
    workhr(u, today, n) {
      let month = new Date().getMonth() + 1;
      let total_hr = 0;
      let pubDay = 0;
      let add_hr = 0;
      let sub_hr = 0;
      // 機構減班時數
      let institutionReduceClassHour = 0;

      if (!this.isReady) {
        return -1;
      }

      for (let day = 1; day <= this.getDays; ++day) {
        if (this.month < month || (this.month === month && day < today)) {
          if (this.shiftOfCurrentMonth[u] && this.shiftOfCurrentMonth[u][day]) {
            let i = this.shiftOfCurrentMonth[u][day];
            if (i.shift_type == "公") {
              pubDay += 1;
            } else {
              total_hr += i.shift.work_hours;
            }
          }
        }
      }

      this.adjustHr
        .filter((item) => {
          return (
            item.user == u &&
            parseInt(item.date.split("-")[1]) == month &&
            parseInt(item.date.split("-")[2]) <= today
          );
        })
        .forEach((i) => {
          if (i.adjustment_type == 0) {
            add_hr += i.hours;
          } else if (i.adjustment_type == 1) {
            sub_hr += i.hours;
            if (
              this.$getTimeAdjustmentItemValue(
                "ITEM_INSTITUTION_REDUCE_CLASS"
              ) === i.adjustment_item
            ) {
              institutionReduceClassHour += i.hours;
            }
          }
        });
      switch (n) {
        case 1: //總計 = 累計至當日的(user 所有班別時數總和 + 公假時數 + 加班 - 減班)
          return total_hr + pubDay * this.workDayHours + add_hr - sub_hr;
        case 2: //公假 = 累計到當日的公假天數
          return pubDay;
        case 3: //加班
          return add_hr;
        case 4: //減班 = 機構減班
          return institutionReduceClassHour;
        default:
          return -1;
      }
    },

    //不出勤天數計算
    offHours(u, index) {
      let total = 0;
      let special = 0;
      let count = 0;
      let notCount = 0;
      let noRest = 0;

      if (!this.isReady) {
        return -1;
      }

      for (let day = 1; day <= this.getDays; ++day) {
        if (this.shiftOfCurrentMonth[u] && this.shiftOfCurrentMonth[u][day]) {
          let i = this.shiftOfCurrentMonth[u][day];
          if (
            this.$getShiftTypeValue("VALUE_PAID_LEAVE") === i.shift.shift_type
          ) {
            if (
              i.shift.name[0] == "例" ||
              i.shift.name[0] == "休" ||
              i.shift.name[0] == "國"
            ) {
              ++special;
            } else {
              ++count;
            }
          } else if (
            this.$getShiftTypeValue("VALUE_UNPAID_LEAVE") === i.shift.shift_type
          ) {
            ++notCount;
          }
        }
      }

      let month = new Date().getMonth() + 1;
      this.adjustHr
        .filter((item) => {
          return (
            item.user == u && (
              parseInt(item.date.split("-")[1]) < month || (
                parseInt(item.date.split("-")[1]) === month &&
                parseInt(item.date.split("-")[2]) <= this.date
              )
            )
          );
        })
        .forEach((i) => {
          if (
            this.$getTimeAdjustmentItemValue('ITEM_OFF_DAY_ATTENDANCE') === i.adjustment_item ||
            this.$getTimeAdjustmentItemValue('ITEM_NATIONAL_HOLIDAY_ATTENDANCE') === i.adjustment_item
          ) {
            ++noRest;
          }
        });

      this.promiseData.forEach((item) => {
        let day = parseInt(item.date.split("-")[2]);
        // 只有當
        // 1. 當日無預排結果
        // 2. 預排結果與預約假勤不同
        // 時才計算，不重複計算假日
        if (
          item.user.id === u &&
          (
            !this.shiftOfCurrentMonth[u] ||
            !this.shiftOfCurrentMonth[u][day] ||
            this.shiftOfCurrentMonth[u][day].shift.shift_type !== item.shift_type
          )
        ) {
          if (
            this.$getPromiseLeaveCategoryValue("PAID_LEAVE") == this.$getPromiseLeaveCategoryByItemValue(item.shift_type)
          ) {
            ++count;
          } else {
            ++notCount;
          }
        }
      });

      switch (index) {
        case 1: // 例休國
          return special;
        case 2: // 有薪假(排除公假) + 減班「員工自假」
          return count;
        case 3: // 無薪假
          return notCount;
        case 4: // 總計 = 例假日 + 休假日 + 國定假日 + 計薪請假 + 扣薪請假
          total = special + count + notCount;
          return total;
        case 5:
          return (special - noRest);
        default:
          return -1;
      }
    },

    //取得標誌按鈕的樣式
    getRS(ev) {
      this.rsShow = true;
      this.rsClass = ev.target.className.split(" ")[1];
    },

    //取得各個標誌的內容
    getRemarkSquare(index) {
      if (this.remarkSquareData[index] && this.remarkSquareData[index].content) {
        return this.remarkSquareData[index].content;
      }
      return '';
    },

    //之後要送往remark-squares api的資料先暫存在remarkS的陣列中
    setRemarkContent(ev) {
      let data = {};
      // rs1 or rs2 or rs3
      let className = ev.target.parentNode.childNodes[0].classList[1];
      data.index = className[2] - 1;
      data.content = ev.target.value.toString();

      this.remarkSquare.push(data);
    },

    //編輯個人當天的班別
    editShift(ev, info) {
      //加標誌到各筆班別資料
      if (
        this.rsShow == true &&
        this.rsClass != "" &&
        $(ev.target).closest("td").hasClass("couldEdit")
      ) {
        let data = {};
        data.result = info.id;
        let classListStr = $(ev.target).closest("td").attr("class");
        $(ev.target).closest("td").addClass(this.rsClass);

        let check = this.preResultRemarkData.find((item) => {
          return data.result == item.result;
        });

        if (classListStr.indexOf("rs1") != -1) {
          $(ev.target).closest("td").removeClass("rs1");
        } else if (classListStr.indexOf("rs2") != -1) {
          $(ev.target).closest("td").removeClass("rs2");
        } else if (classListStr.indexOf("rs3") != -1) {
          $(ev.target).closest("td").removeClass("rs3");
        }

        if (classListStr.indexOf(this.rsClass) != -1) {
          if (check) {
            fetch(`/api/preresult-remarks/${check.id}/`, {
              headers: {
                "X-CSRFToken": `${this.csrfToken}`,
                "content-type": "application/json",
              },
              method: "DELETE",
            }).catch((err) => {
              console.log(err);
            });
          }
        } else {
          switch (this.rsClass) {
            case "rs1":
              data.content = this.remarkSquareData[0].id;
              break;
            case "rs2":
              data.content = this.remarkSquareData[1].id;
              break;
            case "rs3":
              data.content = this.remarkSquareData[2].id;
              break;
          }
          let exist = this.resultRS.find((i) => {
            return i.result == info.id;
          });

          //之後要送往preresult-remarks api的資料先暫存在resultRS的陣列中
          if (!exist) {
            this.resultRS.push(data);
          } else {
            this.resultRS.forEach((i) => {
              if (i.result == info.id) {
                i.content = data.content;
              }
            });
          }
        }

      }

      if (
        this.isEdit == true &&
        $(ev.target).closest("td").hasClass("couldEdit")
      ) {
        $("#changeShiftModal").modal("show");
        if (info != undefined) {
          this.changeInfo = info;
        }
      } else {
        $("#changeShiftModal").modal("hide");
      }
    },

    //送出編輯班別的結果到待傳到api的資料
    editResult(changeShiftInfo) {
      $("#changeShiftModal").modal("hide");
      if (changeShiftInfo) {
        let obj = {
          id: changeShiftInfo.id,
          date: changeShiftInfo.date,
          user: changeShiftInfo.user,
          shift: changeShiftInfo.shift,
          station: changeShiftInfo.station ? changeShiftInfo.station : null,
        };
        let duplicate = this.changedResult.findIndex((d) => {
          return d.user == obj.user && d.date == obj.date;
        });
        if (duplicate > -1) {
          this.changedResult.splice(duplicate, 1);
        }
        this.changedResult.push(obj);
        let d = moment(changeShiftInfo.date).date();
        if (!this.shiftOfCurrentMonth[changeShiftInfo.user]) {
          this.$set(this.shiftOfCurrentMonth, changeShiftInfo.user, {});
        }
        changeShiftInfo.isModified = true;
        this.$set(
          this.shiftOfCurrentMonth[changeShiftInfo.user],
          d,
          changeShiftInfo
        );
      }

      this.changeInfo = {};
    },

    //回傳對應標誌的樣式
    whichBorder(obj) {
      let f;
      if (obj != undefined) {
        f = this.preResultRemarkData.find((i) => {
          return i.result == obj.id;
        });
      }
      let id = [0, 0, 0];
      if (this.remarkSquareData[0] && this.remarkSquareData[0].id) {
        id[0] = this.remarkSquareData[0].id;
      }
      if (this.remarkSquareData[1] && this.remarkSquareData[1].id) {
        id[1] = this.remarkSquareData[1].id;
      }
      if (this.remarkSquareData[2] && this.remarkSquareData[2].id) {
        id[2] = this.remarkSquareData[2].id;
      }

      if (f) {
        switch (f.content) {
          case id[0]:
            return "rs1";
          case id[1]:
            return "rs2";
          case id[2]:
            return "rs3";
        }
      }
    },

    getUserShift(userId, date) {
      if (this.isReady) {
        if (
          this.shiftOfCurrentMonth[userId] &&
          this.shiftOfCurrentMonth[userId][date]
        ) {
          return this.shiftOfCurrentMonth[userId][date];
        }

        let promise = this.promiseData.find((i) => {
          return (
            i.user.id === userId &&
            parseInt(i.date.split("-")[1]) === this.month &&
            parseInt(i.date.split("-")[2]) === date
          );
        });
        if (promise) {
          let shiftType;
          if (this.$getPromiseLeaveCategoryValue('PAID_LEAVE') == this.$getPromiseLeaveCategoryByItemValue(promise.shift_type)) {
            shiftType = this.$getShiftTypeValue('VALUE_PAID_LEAVE');
          } else {
            shiftType = this.$getShiftTypeValue('VALUE_UNPAID_LEAVE');
          }


          return {
            id: 0,
            date: promise.date,
            user: userId,
            shift: {
              shift_type: shiftType,
              name: this.$getPromiseLeaveItemText(promise.shift_type),
              code: '',
            },
          };
        }
      }

      return {
        id: 0,
        date:
          this.year +
          "-" +
          String(this.month).padStart(2, "0") +
          "-" +
          String(date).padStart(2, "0"),
        user: userId,
      };
    },
    // 跟班按鈕觸發
    followShiftEdit() {
      if (this.isEdit == true) {
        $("#followShiftModal").modal("show");
      }
    },

    // 送出跟班 api
    sendFollowShift(followInfo) {
      $("#followShiftModal").modal("hide");
      let preresults = this.shiftOfCurrentMonth[followInfo.follower] || {};
      let results = this.shiftOfCurrentMonth[followInfo.mentor];
      Object.keys(results).forEach((key) => {
        let e = results[key];
        if (e.user == followInfo.mentor) {
          let followStart = parseInt(followInfo.startDate.substring(8));
          let followEnd = parseInt(followInfo.endDate.substring(8));
          let shiftDate = parseInt(e.date.substring(8));
          if (shiftDate <= followEnd && shiftDate >= followStart) {
            let obj = {
              id: preresults[key] ? preresults[key].id : 0,
              user: followInfo.follower,
              shift: e.shift,
              station: e.station,
              date: e.date,
            };
            let duplicate = this.changedResult.findIndex((d) => {
              return d.user == obj.user && d.date == obj.date;
            });
            if (duplicate > -1) {
              this.changedResult.splice(duplicate, 1);
            }
            this.changedResult.push(obj);
            if (!this.shiftOfCurrentMonth[followInfo.follower]) {
              this.$set(this.shiftOfCurrentMonth, followInfo.follower, {});
            }
            obj.isModified = true;
            this.$set(
              this.shiftOfCurrentMonth[followInfo.follower],
              shiftDate,
              obj
            );
          }
        }
      });
      console.log(this.changedResult);
    },
    // 預排假顯示
    userReserve(id, month, day) {
      let found = this.reserveData.find((item) => {
        if (item.user == id) {
          return (
            item.date.split("-")[1] == month && item.date.split("-")[2] == day
          );
        }
      });
      if (found) {
        return true;
      }

      return false;
    },

    //取得當日人力配置的資料
    getDemandList() {
      let demandList = this.demandData.filter((i) => {
        return moment([this.year, this.month - 1, this.date]).isSame(
          moment(i.date),
          "month"
        );
      });
      if (demandList.length > 0) {
        for (let day = 1; day <= this.getDays; ++day) {
          demandList[day - 1].D[1] = 0;
          demandList[day - 1].E[1] = 0;
          demandList[day - 1].N[1] = 0;
        }
        for (let userId in this.shiftOfCurrentMonth) {
          for (let day in this.shiftOfCurrentMonth[userId]) {
            switch (this.shiftOfCurrentMonth[userId][day].shift.shift_type) {
              case 0:
                demandList[day - 1].D[1] += 1;
                break;
              case 1:
                demandList[day - 1].E[1] += 1;
                break;
              case 2:
                demandList[day - 1].N[1] += 1;
                break;
            }
          }
        }
        this.adjustHr.forEach(adjustment => {
          if (adjustment.adjustment_item === this.$getTimeAdjustmentItemValue("ITEM_OFF_DAY_ATTENDANCE")) {
            let day = new Date(adjustment.date).getDate();
            if (adjustment.remark === "白班") {
              demandList[day - 1].D[1] += 1;
            } else if (adjustment.remark === "小夜") {
              demandList[day - 1].E[1] += 1;
            } else if (adjustment.remark === "大夜") {
              demandList[day - 1].N[1] += 1;
            }
          }
        })
      }
      this.demandList = demandList;
    },
    //-------------------------------------------------
  },

  watch: {
    month() {
      Promise.all([
        this.getUserData(),
        this.getPreResults(),
        this.getLastMonthData(),
        this.getAdjustment(),
        this.getTotalPerDayData(),
      ]).then(() => {
        this.getDemandList();
      });
      this.getPromiseData();
    },
  },
};
</script>
<style scoped lang="scss">
#results {
  height: 100vh;
  width: 90vw;
  #top-info {
    height: 70px;
    width: 88vw;
    position: fixed;
    top: 100px;

    .time {
      height: 70px;
      width: 30%;
      float: left;
      box-sizing: border-box;
      padding: 10px 15px;

      .year {
        display: inline;
      }
      .month {
        display: inline;
      }
    }

    .bt-group {
      float: right;
      height: 70px;
      width: 70%;
      padding: 10px 10%;

      .add-sub-wrapper {
        border: 1px solid #a6a6a6;
        border-radius: 0.25rem;
        width: 120px;
        text-align: center;
        margin: 0.25em;
        cursor: pointer;
        font-size: 1rem;
        float: right;

        #current {
          box-sizing: border-box;
          border: 1px solid #a6a6a6;
          display: inline-block;
          margin: 0px;
        }
        #prev {
          display: inline-block;
        }
        #next {
          display: inline-block;
        }
      }
    }
  }
  .calendar {
    position: fixed;
    top: 180px;
    width: 88vw;
    height: 73vh;
    // overflow: auto;
    overflow-y: scroll;

    .master-schedule-table {
      text-align: center;
      width: 100%;
      height: 70;
      // border-top: 0;

      /* here is the trick */
      tbody:nth-of-type(1) tr:nth-of-type(1) td {
        border-top: none !important;
      }

      td {
        padding: 0;
      }

      .grid-width {
        width: 45px;
        white-space: nowrap;
      }

      .couldEdit {
        &:hover {
          cursor: pointer;
        }
      }

      ::v-deep .gray-background,
      .gray-background {
        background: #f2f2f2 !important;
      }

      .white-background {
        background: white;
      }

      .identity-circle {
        width: 0.5rem;
        height: 0.5rem;
        border-radius: 50%;
        display: inline-block;
      }

      .senior {
        background: #37419a;
      }

      .junior {
        background: #84b1ed;
      }

      .administrative {
        background: #eaeaea;
      }

      .new-in {
        border: 1px solid #84b1ed;
      }

      .remark {
        width: 5rem;
        text-align: center;
      }

      .remark-grid {
        width: 3rem;
        background: #f2f2f2;
        border: none;
        text-align: center;
      }

      .mark {
        width: 10px;
        height: 10px;
        background: white;
        float: left;
        margin-left: 1rem;
        margin-top: 4px;
        margin-right: 1rem;
      }

      .mark-explanation {
        border: none;
        float: left;
      }
    }
  }
}
</style>
