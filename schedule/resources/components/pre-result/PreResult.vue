<template>
  <div id="pre-result" v-cloak>
    <loading v-show="!isReady"></loading>
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
        <div id="btn-manage">
          <div
          class="icon-bts follow-btn"
          v-show="isEdit"
          data-tooltip="tooltip"
          title="跟班"
          @click="followShiftEdit()"
          @followshiftedit="sendFollowShift(data)">
            <svg
              class="icon-color"
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
            >
              <path
                d="M.002 20h6.001c-.028-6.542 2.995-3.697 2.995-8.901 0-2.009-1.311-3.099-2.998-3.099-2.492 0-4.226 2.383-1.866 6.839.775 1.464-.825 1.812-2.545 2.209-1.49.344-1.589 1.072-1.589 2.333l.002.619zm20.498-7c-1.932 0-3.5 1.567-3.5 3.5s1.568 3.5 3.5 3.5 3.5-1.567 3.5-3.5-1.568-3.5-3.5-3.5zm1.5 4h-1v1h-1v-1h-1v-1h1v-1h1v1h1v1zm-4.814 3h-9.183l-.003-.829c0-1.679.133-2.649 2.118-3.107 2.243-.518 4.458-.981 3.394-2.945-3.156-5.82-.901-9.119 2.488-9.119 4.06 0 4.857 4.119 3.085 7.903-1.972.609-3.419 2.428-3.419 4.597 0 1.38.589 2.619 1.52 3.5z"
              />
            </svg>
          </div>
          <div class="mark-group icon-bts" v-show="isEdit">
            <div class="mark-title">加標誌</div>
            <div class="mark-content" @click="getRS($event)">
              <div class="marks rs1"></div>
              <div class="marks rs2"></div>
              <div class="marks rs3"></div>
            </div>
          </div>
          <div
            class="icon-bts"
            v-show="isEdit"
            @click="callResetModal()"
            :style="{cursor: couldReset()}"
            data-tooltip="tooltip"
            title="重算"
          >
            <svg
              class="icon-color"
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
            >
              <path
                d="M15.408 23h-15.408v-22h22v9.683c-.622-.296-1.293-.502-2-.603v-3.08h-18v14h11.26c.566.81 1.3 1.49 2.148 2zm2.257-8.669c.402-.206.852-.331 1.335-.331 1.455 0 2.67 1.042 2.941 2.418l1.96-.398c-.456-2.291-2.475-4.02-4.901-4.02-.957 0-1.845.278-2.604.745l-1.396-1.745-1 5h5l-1.335-1.669zm5.335 8.669l-1.396-1.745c-.759.467-1.647.745-2.604.745-2.426 0-4.445-1.729-4.901-4.02l1.96-.398c.271 1.376 1.486 2.418 2.941 2.418.483 0 .933-.125 1.335-.331l-1.335-1.669h5l-1 5z"
              />
            </svg>
          </div>
          <div
            class="icon-bts save-btn"
            v-show="isEdit"
            @click="sendToResults()"
            data-tooltip="tooltip"
            title="儲存"
          >
            <svg
              class="icon-color"
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
            >
              <path
                d="M15.003 3h2.997v5h-2.997v-5zm8.997 1v20h-24v-24h20l4 4zm-19 5h14v-7h-14v7zm16 4h-18v9h18v-9z"
              />
            </svg>
          </div>
          <div
            class="icon-bts edit-btn"
            v-show="!isEdit"
            @click="isEdit = true"
            data-tooltip="tooltip"
            title="編輯"
          >
            <svg
              class="icon-color"
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
            >
              <path
                d="M5 21h-5v-2h5v2zm3.424-5.718l4.402 4.399-5.826 1.319 1.424-5.718zm15.576-6.748l-9.689 9.804-4.536-4.536 9.689-9.802 4.536 4.534z"
              />
            </svg>
          </div>
          <div class="icon-bts check-btn" data-tooltip="tooltip" title="檢核">
            <svg
              class="icon-color"
              width="24"
              height="24"
              xmlns="http://www.w3.org/2000/svg"
              fill-rule="evenodd"
              clip-rule="evenodd"
            >
              <path
                d="M9 21h-9v-2h9v2zm6.695-2.88l-3.314-3.13-1.381 1.47 4.699 4.54 8.301-8.441-1.384-1.439-6.921 7zm-6.695-1.144h-9v-2h9v2zm8-3.976h-17v-2h17v2zm7-4h-24v-2h24v2zm0-4h-24v-2h24v2z"
              />
            </svg>
          </div>
          <div class="icon-bts announce-btn" data-tooltip="tooltip" title="發佈">
            <svg
              class="icon-color"
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
            >
              <path
                d="M2.655 15.423c-.835.892-1.542 1.158-2.655.86l2.647 4.585c.257-1.094.815-1.708 2.005-1.985l15.348-3.732-6.335-10.972-11.01 11.244zm11.32 2.707l-.467 2.118c-.094.378-.391.674-.769.771l-2.952.774c-.365.095-.753-.012-1.018-.28l-1.574-1.712 1.605-.395.646.77c.176.177.432.248.674.186l1.598-.425c.252-.064.449-.261.511-.512l.162-.906 1.584-.389zm8.719-11.267l-2.684 1.613-.756-1.262 2.686-1.612.754 1.261zm-4.396-1.161l-1.335-.616 1.342-2.914 1.335.617-1.342 2.913zm5.619 6.157l-3.202-.174.081-1.469 3.204.175-.083 1.468z"
              />
            </svg>
          </div>
        </div>
      </div>
    </div>
    <div class="calendar">
      <table
        class="master-scedule-table"
        width="100%"
        height="70"
        border="1"
        cellspacing="0"
        bordercolor="black"
      >
        <pre-result-table-head :year="year" :month="month" :getDays="getDays"></pre-result-table-head>
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
            <td class="white-background">{{ workhr(u.id, month, getDays, 0) }}</td>
            <td class="gray-background">{{ workhr(u.id, month, date, 1) }}</td>
            <td class="white-background">{{ workhr(u.id, month, date, 3) }}</td>
            <td class="white-background">{{ workhr(u.id, month, date, 4) }}</td>
            <td class="white-background">{{ workhr(u.id, month, date, 2) }}</td>
            <td class="gray-background">{{ offHours(u.id, month, 4) }}</td>
            <td class="white-background">{{ offHours(u.id, month, 1) }}</td>
            <td class="white-background">{{ offHours(u.id, month, 2) }}</td>
            <td class="white-background">{{ offHours(u.id, month, 3) }}</td>
            <td class="gray-background">{{ workhr(u.id, month, getDays, 5) }}</td>
            <td class="white-background">-</td>
            <td class="white-background">-</td>
          </tr>
          <tr class="gray-background">
            <td colspan="4">排班統計</td>
            <td class="grid-width" v-for="(day, d4) in getDays" :key="d4">
              <div>{{ day }}</div>
            </td>
            <td></td>
            <td colspan="12">標誌說明</td>
          </tr>
          <shift-statistics
            :isReady="isReady"
            :isEdit="isEdit"
            shiftName="白班"
            shiftKey="D"
            :getDays="getDays"
            :getDemand="getDemand"
            rs="rs1"
            :remarkContent="getRemarkSquare(1)"
          ></shift-statistics>
          <shift-statistics
            :isReady="isReady"
            :isEdit="isEdit"
            shiftName="小夜班"
            shiftKey="E"
            :getDays="getDays"
            :getDemand="getDemand"
            rs="rs2"
            :remarkContent="getRemarkSquare(2)"
          ></shift-statistics>
          <shift-statistics
            :isReady="isReady"
            :isEdit="isEdit"
            shiftName="大夜班"
            shiftKey="N"
            :getDays="getDays"
            :getDemand="getDemand"
            rs="rs3"
            :remarkContent="getRemarkSquare(3)"
          ></shift-statistics>
        </tbody>
      </table>
    </div>
    <change-shift-modal
      :changeShift="changeInfo"
      :shiftData="shiftData"
      :stationPicker="stationPicker"
      v-if="!rsShow && isEdit"
    ></change-shift-modal>

    <follow-shift-modal :userData="userData" :follower="follower"></follow-shift-modal>

    <recalculate-modal
      :year="year"
      :month="month"
      :getDays="getDays"
      v-show="couldRecalculate && (couldReset() !== 'not-allowed')"
    ></recalculate-modal>
    <error-alert-modal v-show="!couldRecalculate"></error-alert-modal>
  </div>
</template>
<script>
import moment from "moment";
import "moment/locale/zh-tw";
import Loading from "./Loading.vue";
import PreResultTableHead from "./PreResultTableHead.vue";
import UserShiftCell from "./UserShiftCell.vue";
import ShiftStatistics from "./ShiftStatistics.vue";
import ChangeShiftModal from "./ChangeShiftModal.vue";
import FollowShiftModal from "./FollowShiftModal.vue";
import RecalculateModal from "./RecalculateModal.vue";
import ErrorAlertModal from "./ErrorAlertModal.vue";

moment.locale("zh-tw");
export default {
  components: {
    Loading,
    PreResultTableHead,
    UserShiftCell,
    ShiftStatistics,
    ChangeShiftModal,
    FollowShiftModal,
    RecalculateModal,
    ErrorAlertModal,
  },

  props: {
    csrfToken: {
      type: String,
      default: "",
    },
  },

  data() {
    return {
      year: moment().year(),
      month: moment().add(1, "months").month() + 1,
      date: moment().date(),
      userData: [],
      preResultData: [],
      adjustHr: [],
      lastMonthData: [],
      userRemarkData: [],
      remarks: [],
      demandData: [],
      remarkSquareData: [],
      preResultRemarkData: [],
      remarkS: [],
      shiftData: [],
      resultRS: [],
      changeInfo: {},
      isReady: false,
      isEdit: false,
      rsShow: false,
      isConfirm: false,//確認後控制正在重算載入畫面的變數
      couldRecalculate: false,
      rsClass: "",
      follower: {},
      stationData: [],
      shiftOfCurrentMonth: {},
      changedResult: [],
      rs: "",
    };
  },

  mounted() {
    this.getUserData();
    this.getPreResults();
    this.getLastMonthData();
    this.getAdjustment();
    this.getUserRemark();
    this.getTotalPerDayData();
    this.getRemarkSquareData();
    this.getPreResultRemarkData();
    this.getShiftData();
    this.getStationData();
  },

  computed: {
    //計算該年該月的天數
    getDays() {
      return moment([this.year, this.month - 1, 1]).daysInMonth();
    },

    //取得當日人力配置的資料
    getDemand() {
      let real = this.demandData.filter((i) => {
        return moment([this.year, this.month - 1, this.date]).isSame(
          moment(i.date),
          "month"
        );
      });

      return real;
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
      fetch("/api/users/?mode=resource")
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

      fetch(`/api/preresults/?start=${this.year}-${this.month}-01&end=${this.year}-${this.month}-${this.getDays}`)
        .then((res) => {
          return res.json();
        })
        .then((data) => {
          this.preResultData = data;
          //處理懶加載畫面的變數設置
          if (this.preResultData.length != 0) {
            let processedShifts = {}; // index by user id
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
        })
        .catch((err) => {
          console.log(err);
        });
    },

    //取得前一個月最後幾天排班資料
    getLastMonthData() {
      fetch(`/api/last-month-continue?month_head=${this.year}-${this.month}-01`)
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
      fetch(`/api/time-adjustment/?start=${this.year}-${this.month}-01&end=${this.year}-${this.month}-${this.getDays}`)
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
      fetch(`/api/total-per-day/?start=${this.year}-${this.month}-01&end=${this.year}-${this.month}-${this.getDays}`)
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

    getStationData() {
      let self = this;
      this.$httpClient
        .get("/api/stations/")
        .then((response) => {
          self.stationData = response.data;
        })
        .catch((err) => {
          console.log(err);
        });
    },

    //----------------------------------------------------

    //-------------------各個function----------------------

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
          return "couldEdit";
        }
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

      this.remarks.push(data);
    },

    //排班時數、出勤時數、當月差額計算
    workhr(u, m, today, n) {
      let month = new Date().getMonth() + 1;
      let total_hr = 0;
      let pub_hr = 0;
      let add_hr = 0;
      let sub_hr = 0;
      let diff = 0;

      let arr = this.preResultData.filter((userItem) => {
        if (userItem.user == u && parseInt(userItem.date.split("-")[1]) == m) {
          return parseInt(userItem.date.split("-")[2]) <= today;
        }
      });
      let adjust = this.adjustHr.filter((item) => {
        if (m == month) {
          return (
            item.user == u &&
            parseInt(item.date.split("-")[1]) == m &&
            parseInt(item.date.split("-")[2]) <= today
          );
        } else {
          return item.user == u && parseInt(item.date.split("-")[1]) == m;
        }
      });

      arr.forEach((i) => {
        total_hr += i.shift.work_hours;
      });
      adjust.forEach((i) => {
        if (i.adjustment_type == 0) {
          add_hr += i.hours;
        }
      });
      adjust.forEach((i) => {
        if (i.adjustment_type == 1) {
          sub_hr += i.hours;
        }
      });
      arr.forEach((i) => {
        if (i.shift_type == "公") {
          pub_hr += i.shift.work_hours / 8;
        }
      });
      switch (n) {
        case 0: //排班
          return total_hr;
        case 1: //總計
          return total_hr + add_hr + sub_hr;
        case 2: //公假
          return pub_hr;
        case 3: //加班
          return add_hr;
        case 4: //減班
          return sub_hr;
        case 5: //當月差額
          let a = this.offHours(u, this.month, 4);
          if (total_hr) {
            diff = total_hr + add_hr - sub_hr + a * 8 - today * 8;
            return diff;
          } else {
            return 0;
          }
      }
    },

    //不出勤時數計算
    offHours(u, m, index) {
      let total = 0;
      let special = 0;
      let count = 0;
      let notCount = 0;

      //例休國 index1
      let arr1 = this.preResultData.filter((i) => {
        if (
          i.user == u &&
          parseInt(i.date.split("-")[1]) == m &&
          i.shift.shift_type == 5
        ) {
          return (
            i.shift.name[0] == "例" ||
            i.shift.name[0] == "休" ||
            i.shift.name[0] == "國"
          );
        }
      });
      //計薪 index2
      let arr2 = this.preResultData.filter((i) => {
        if (
          i.user == u &&
          parseInt(i.date.split("-")[1]) == m &&
          i.shift.shift_type == 5
        ) {
          return (
            i.shift.name[0] != "例" &&
            i.shift.name[0] != "休" &&
            i.shift.name[0] != "國"
          );
        }
      });
      //不計薪 index3
      let arr3 = this.preResultData.filter((i) => {
        if (i.user == u && parseInt(i.date.split("-")[1]) == m) {
          return i.shift.shift_type == 6;
        }
      });
      //計薪 公假
      let arrP = this.preResultData.filter((i) => {
        if (i.user == u && parseInt(i.date.split("-")[1]) == m) {
          return i.shift.shift_type == 3;
        }
      });

      special = arr1.length;
      count = arr2.length + arrP.length;
      notCount = arr3.length;

      switch (index) {
        case 1:
          return special;
        case 2:
          return count;
        case 3:
          return notCount;
        case 4:
          total = special + count + notCount;
          return total;
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
      let f = this.remarkSquareData.find((i) => {
        return i.id == index;
      });

      if (f) {
        return f.content;
      }
    },

    //之後要送往remark-squares api的資料先暫存在remarkS的陣列中
    setRemarkContent(ev) {
      let data = {};
      let id = ev.target.parentNode.childNodes[0].classList[1];
      data.id = id[2];
      data.content = ev.target.value.toString();

      this.remarkS.push(data);
    },

    //編輯個人當天的班別
    editShift(ev, info) {
      //加標誌到各筆班別資料
      if (
        this.rsShow == true &&
        this.rsClass != "" &&
        ev.target.parentNode.classList[2] == "couldEdit"
      ) {
        let data = {};
        data.result = info.id;
        let classListStr = JSON.stringify(ev.target.parentNode.classList);
        ev.target.parentNode.classList.add(this.rsClass);

        let check = this.preResultRemarkData.find((item) => {
          return data.result == item.result;
        });

        if (classListStr.indexOf("rs1") != -1) {
          ev.target.parentNode.classList.remove("rs1");
          fetch(`/api/preresult-remarks/${check.id}/`, {
            headers: {
              "X-CSRFToken": `${this.csrfToken}`,
              "content-type": "application/json",
            },
            method: "DELETE",
          })
            .then((res) => {
              return res.json();
            })
            .catch((err) => {
              console.log(err);
            });
        } else if (classListStr.indexOf("rs2") != -1) {
          ev.target.parentNode.classList.remove("rs2");
          fetch(`/api/preresult-remarks/${check.id}/`, {
            headers: {
              "X-CSRFToken": `${this.csrfToken}`,
              "content-type": "application/json",
            },
            method: "DELETE",
          })
            .then((res) => {
              return res.json();
            })
            .catch((err) => {
              console.log(err);
            });
        } else if (classListStr.indexOf("rs3") != -1) {
          ev.target.parentNode.classList.remove("rs3");
          fetch(`/api/preresult-remarks/${check.id}/`, {
            headers: {
              "X-CSRFToken": `${this.csrfToken}`,
              "content-type": "application/json",
            },
            method: "DELETE",
          })
            .then((res) => {
              return res.json();
            })
            .catch((err) => {
              console.log(err);
            });
        }

        switch (this.rsClass) {
          case "rs1":
            data.content = 1;
            break;
          case "rs2":
            data.content = 2;
            break;
          case "rs3":
            data.content = 3;
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

        this.whichBorder(info);
      }

      if (
        this.isEdit == true &&
        ($(ev.target).hasClass("couldEdit") ||
          $(ev.target).parent().hasClass("couldEdit"))
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
        this.changedResult.push({
          id: changeShiftInfo.id,
          date: changeShiftInfo.date,
          user: changeShiftInfo.user,
          shift: changeShiftInfo.shift,
          station: changeShiftInfo.station ? changeShiftInfo.station : null,
        });
        let d = moment(changeShiftInfo.date).date();
        if (!this.shiftOfCurrentMonth[changeShiftInfo.user]){
          this.$set(this.shiftOfCurrentMonth, changeShiftInfo.user, {});
        }
        this.$set(this.shiftOfCurrentMonth[changeShiftInfo.user], d, changeShiftInfo);
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

      if (f) {
        switch (f.content) {
          case 1:
            return "rs1";
          case 2:
            return "rs2";
          case 3:
            return "rs3";
        }
      }
    },

    getUserShift(userId, date) {
      if (
        this.shiftOfCurrentMonth[userId] &&
        this.shiftOfCurrentMonth[userId][date]
      ) {
        return this.shiftOfCurrentMonth[userId][date];
      }
      return {
        id: 0,
        date: this.year + "-" + String(this.month).padStart(2, "0") + "-" + String(date).padStart(2, "0"),
        user: userId,
      };
    },

    followShiftEdit() {
      if (this.isEdit == true) {
        $("#followShiftModal").modal("show");
      }
    },

    // 送出跟班 api
    sendFollowShift(followInfo) {
      $("#followShiftModal").modal("hide");
      let results = this.shiftOfCurrentMonth[followInfo.mentor]
      Object.keys(results).forEach(key=>{
        let e = results[key]
        if (e.user == followInfo.mentor){

          let obj = {
            user: followInfo.follower,
            shift: e.shift,
            station: e.station,
            date: e.date
          }
          this.changedResult.push(obj)
          let d = moment(e.date).date();
          let d_start = parseInt(followInfo.startDate.substring(8))
          let d_end = parseInt(followInfo.endDate.substring(8))
          let d_d = parseInt(e.date.substring(8))
          if (d_d <= d_end && d_d >= d_start){
            if(!this.shiftOfCurrentMonth[followInfo.follower]){
              this.$set(this.shiftOfCurrentMonth, followInfo.follower, {});
            }
            this.$set(this.shiftOfCurrentMonth[followInfo.follower], d, obj);
          }
        }
      });

      // let url = '/api/follow-shift?start=' + followInfo.startDate +
      // '&end=' + followInfo.endDate + '&follower=' + followInfo.follower.toString() +
      // '&mentor=' + followInfo.mentor.toString();
      // this.$httpClient
      //   .get(url)
      //   .then((response) => {
      //     console.log(response);
      //     $("#followShiftModal").modal("hide");
      //   })
      //   .catch((err) => {
      //     console.log(err);
      //   });
    },

    sendToResults() {
      this.followEdit = false;
      this.rsShow = false;

      let promises = [];
      this.changedResult.forEach((i) => {
        let data = {
          user: i.user,
          shift: i.shift.id,
          date: i.date,
          station: i.station ? i.station.id : null,
        };
        let promise;
        if (i.id === 0) {
          promise = fetch("/api/preresults/", {
            headers: {
              "X-CSRFToken": this.csrfToken,
              "content-type": "application/json",
            },
            body: JSON.stringify(data),
            method: "POST",
          }).catch((err) => {
            console.log(err);
          });
        } else {
          promise = fetch(`/api/preresults/${i.id}/`, {
            headers: {
              "X-CSRFToken": this.csrfToken,
              "content-type": "application/json",
            },
            body: JSON.stringify(data),
            method: "PATCH",
          }).catch((err) => {
              console.log(err);
          });
        }
        promises.push(promise);
      });
      Promise.all(promises).then(() => {
        this.getPreResults();
      });

      this.remarks.forEach((i) => {
        //檢查remarkData中有沒有資料
        let check = this.userRemarkData.find((item) => {
          return item.month == this.month && item.user == i.user;
        });

        //remarkData有資料
        if (check) {
          fetch(`/api/user-remarks/${check.id}/`, {
            headers: {
              "X-CSRFToken": `${this.csrfToken}`,
              "content-type": "application/json",
            },
            body: JSON.stringify(i),
            method: "PATCH",
          }).then((res) => {
            this.getUserRemark();
            return res.json();
          }).catch((err) => {
            console.log(err);
          });
        } else {
          //remarkData沒資料
          fetch("/api/user-remarks/", {
            headers: {
              "X-CSRFToken": `${this.csrfToken}`,
              "content-type": "application/json",
            },
            body: JSON.stringify(i),
            method: "POST",
          }).then((res) => {
            this.getUserRemark();
            return res.json();
          }).catch((err) => {
            console.log(err);
          });
        }
      });

      //正方形標誌說明
      this.remarkS.forEach((item) => {
        let check = this.remarkSquareData.find((i) => {
          return i.id == item.id;
        });

        if (check) {
          fetch(`/api/remark-squares/${check.id}/`, {
            headers: {
              "X-CSRFToken": `${this.csrfToken}`,
              "content-type": "application/json",
            },
            body: JSON.stringify(item),
            method: "PATCH",
          })
            .then((res) => {
              this.getRemarkSquareData();
              return res.json();
            })
            .catch((err) => {
              console.log(err);
            });
        } else {
          fetch("/api/remark-squares/", {
            headers: {
              "X-CSRFToken": `${this.csrfToken}`,
              "content-type": "application/json",
            },
            body: JSON.stringify(item),
            method: "POST",
          })
            .then((res) => {
              this.getRemarkSquareData();
              return res.json();
            })
            .catch((err) => {
              console.log(err);
            });
        }
      });

      //每個使用者每天是否有正方形標誌
      this.resultRS.forEach((i) => {
        let check = this.preResultRemarkData.find((item) => {
          return i.result == item.result;
        });

        if (check) {
          fetch(`/api/preresult-remarks/${check.id}/`, {
            headers: {
              "X-CSRFToken": `${this.csrfToken}`,
              "content-type": "application/json",
            },
            body: JSON.stringify(i),
            method: "PATCH",
          })
            .then((res) => {
              this.getPreResultRemarkData();
              return res.json();
            })
            .catch((err) => {
              console.log(err);
            });
        } else {
          fetch("/api/preresult-remarks/", {
            headers: {
              "X-CSRFToken": `${this.csrfToken}`,
              "content-type": "application/json",
            },
            body: JSON.stringify(i),
            method: "POST",
          })
            .then((res) => {
              this.getPreResultRemarkData();
              return res.json();
            })
            .catch((err) => {
              console.log(err);
            });
        }
      });

      this.changedResult.length = 0;
      this.remarks.length = 0;
      this.remarkS.length = 0;
      this.resultRS.length = 0;
      this.isEdit = false;
    },

    callResetModal() {

      fetch(`/api/results/?start=${this.year}-${this.month}-01&end=${this.year}-${this.month}-${this.getDays}`)
        .then((res)=> {
          return res.json();
        })
        .then((data)=> {
          this.couldRecalculate = data.length === 0 ? true : false;
        })
        .then(()=> {
          this.couldRecalculate === true ? $("#recalculateModal").modal("show") : $("#errorAlertModal").modal("show");
        })
        .catch((err) => {
          console.log(err);
        });
    },

    couldReset() {
      let resetPermit = $.cookie(`Announced${this.month}`);

      if (resetPermit !== "true2") {
        return "pointer";
      } else {
        return "not-allowed";
      }
    },
    //-------------------------------------------------
  },

  watch: {
    month() {
      this.getUserData();
      this.getPreResults();
      this.getLastMonthData();
      this.getAdjustment();
      this.getTotalPerDayData();
    },
  },
};
</script>
<style scoped lang="scss">
#pre-result {
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
      padding: 10px 15px;

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
      #btn-manage {
        float: right;
        .mark-group {
          .mark-title {
            float: left;
            margin-right: 10px;
          }
          .mark-content {
            float: right;
            .marks {
              width: 20px;
              height: 20px;
              float: left;
              margin-right: 10px;
              margin-top: 3px;

              &:hover {
                background: #f0faff;
              }
            }
            .rs1 {
              border: 3px solid #58b4ae;
              &:hover {
                border: 5px solid #58b4ae;
              }
            }
            .rs2 {
              border: 3px solid #84b1ed;
              &:hover {
                border: 5px solid #84b1ed;
              }
            }
            .rs3 {
              border: 3px solid #37419a;
              &:hover {
                border: 5px solid #37419a;
              }
            }
          }
        }
      }
    }
  }
  .calendar {
    position: fixed;
    top: 180px;
    width: 88vw;
    height: 73vh;
    overflow: auto;

    .master-scedule-table {
      text-align: center;

      .grid-width {
        width: 45px;
        white-space: nowrap;
        overflow-x: clip;
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

      .rs1 {
        border: 5px solid #58b4ae;
      }
      .rs2 {
        border: 5px solid #84b1ed;
      }
      .rs3 {
        border: 5px solid #37419a;
      }
    }
  }
}
</style>
