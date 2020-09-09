<template>
  <div id="pre-result" v-cloak>
    <loading v-if="!isReady"></loading>
    <div id="top-info">
      <div class="time">
        <h2 class="year">{{year}}年</h2>
        <h2 class="month">&nbsp;{{month}}月</h2>
      </div>

      <div class="bt-group">
        <div class="add-sub-wrapper" @click="changeMonth($event)">
          <div id="prev">
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
          <div class="icon-bts" id="current">
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
          <div id="next">
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
          <div class="icon-bts follow-btn" v-if="isEdit">
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
          <div class="mark-group icon-bts" v-if="isEdit">
            <div class="mark-title">加標誌</div>
            <div class="mark-content" @click="getRS($event)">
              <div class="marks rs1"></div>
              <div class="marks rs2"></div>
              <div class="marks rs3"></div>
            </div>
          </div>
          <div class="icon-bts" v-if="isEdit">
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
          <div class="icon-bts save-btn" v-if="isEdit" @click="isEdit = false">
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
          <div class="icon-bts edit-btn" v-if="!isEdit" @click="isEdit = true">
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
          <div class="icon-bts check-btn">
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
          <div class="icon-bts announce-btn">
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
        <thead>
          <tr class="gray-background">
            <td rowspan="3">員工編號</td>
            <td rowspan="3">職級</td>
            <td rowspan="3" style="width: 105px">姓名</td>
            <td rowspan="3">前月排班</td>
            <td
              rowspan="2"
              v-for="(day, d1) in getDays"
              :key="`1${d1}`"
              class="grid-width"
              :class="{todayMark: isToday(day)}"
            >{{day}}</td>
            <td rowspan="2" class="remark">備註</td>
            <td rowspan="2">排班</td>
            <td colspan="4">出勤</td>
            <td colspan="4">不出勤</td>
            <td rowspan="2" style="width: 40px">當月差額</td>
            <td rowspan="2" style="width: 40px">剩餘補休</td>
            <td rowspan="2" style="width: 40px">剩餘年假</td>
          </tr>
          <tr class="gray-background">
            <td>總計</td>
            <td>加班</td>
            <td>減班</td>
            <td>公假</td>
            <td>總計</td>
            <td>例休國</td>
            <td>計薪請假</td>
            <td>扣薪請假</td>
          </tr>
          <tr class="day-of-the-week gray-background">
            <td
              v-for="(d, d2) in getDays"
              :key="`2${d2}`"
              class="grid-width"
            >{{ getDayOfTheWeek(d) }}</td>
            <td></td>
            <td>時</td>
            <td>時</td>
            <td>時</td>
            <td>時</td>
            <td>天</td>
            <td>天</td>
            <td>天</td>
            <td>天</td>
            <td>天</td>
            <td>時</td>
            <td>時</td>
            <td>天</td>
          </tr>
        </thead>
        <tbody style="overflow: scroll">
          <tr class="grid-width" v-for="(u, id) in userData" :key="id">
            <td class="white-background">{{ u.eid }}</td>
            <td class="white-background">N{{ u.level == 5 ? 'n' : u.level }}</td>
            <td class="white-background">
              <div style="width: 5rem">
                <div class="identity-circle" :class="whichCircle(u.type_of_user)"></div>
                {{ u.full_name }}
              </div>
            </td>
            <td class="gray-background">{{ lastMonthData[u.id] }}</td>
            <td
              v-for="(dd, d3) in getDays"
              :key="`3${d3}`"
              class="grid-width white-background"
              :class="isPast(ShiftOfUser(u.id, dd))"
              @click="editShift($event, ShiftOfUser(u.id, dd))"
            >
              <div v-if="!isReady">-</div>
              <div
                v-if="ShiftOfUser(u.id, dd)"
                :class="shiftColor(ShiftOfUser(u.id, dd).shift_type)"
              >{{ ShiftOfUser(u.id, dd).shift_type }}</div>
              <div
                v-if="isAdjust(ShiftOfUser(u.id, dd))"
                :class="isAdjust(ShiftOfUser(u.id, dd))[0] == '+' ? 'addWork' : 'subWork'"
              >{{ isAdjust(ShiftOfUser(u.id, dd)) }}</div>
            </td>
            <td class="gray-background">
              <input
                class="remark-gird"
                type="text"
                :value="findRemark(u.id)"
                @blur="getRemark($event, u.id)"
                @keyup.13="$event.target.blur"
                v-if="isEdit"
              />
              <div v-if="!isEdit" class="remark-gird">{{ findRemark(u.id) }}</div>
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
          <tr class="white-background">
            <td colspan="4">白班</td>
            <td v-show="!isReady" class="grid-width" v-for="(ds, d5) in getDays" :key="`5${d5}`">0</td>
            <td v-show="isReady" class="grid-width" v-for="(item, i) in getDemand" :key="i">
              <div :class="item.D[0] > item.D[1] ? 'lack' : 'enough'">{{ item.D[1] }}</div>
            </td>
            <td class="gray-background"></td>
            <td colspan="12">
              <div class="mark rs1"></div>
              <input
                type="text"
                id="1remarkSquare"
                class="mark-explanation"
                v-if="isEdit"
                :value="getRemarkSquare(1)"
                @blur="getRemarkS($event)"
                @keyup.13="$event.target.blur"
              />
              <div
                style="float: left;"
                v-if="!isEdit && (remarkSquareData.length != 0)"
              >{{ getRemarkSquare(1) }}</div>
              <div style="float: left;" v-if="!isEdit && (remarkSquareData.length == 0)">請填寫標誌說明</div>
            </td>
          </tr>
          <tr class="white-background">
            <td colspan="4">小夜班</td>
            <td v-show="!isReady" class="grid-width" v-for="(dn, d6) in getDays" :key="`6${d6}`">0</td>
            <td v-show="isReady" class="grid-width" v-for="(item, i) in getDemand" :key="i">
              <div :class="item.E[0] > item.E[1] ? 'lack' : 'enough'">{{ item.E[1] }}</div>
            </td>
            <td class="gray-background"></td>
            <td colspan="12">
              <div class="mark rs2"></div>
              <input
                type="text"
                id="2remarkSquare"
                class="mark-explanation"
                v-if="isEdit"
                :value="getRemarkSquare(2)"
                @blur="getRemarkS($event)"
                @keyup.13="$event.target.blur"
              />
              <div
                style="float: left;"
                v-if="!isEdit && (remarkSquareData.length != 0)"
              >{{ getRemarkSquare(2) }}</div>
              <div style="float: left;" v-if="!isEdit && (remarkSquareData.length == 0)">請填寫標誌說明</div>
            </td>
          </tr>
          <tr class="white-background">
            <td colspan="4">白班</td>
            <td v-show="!isReady" class="grid-width" v-for="(ds, d7) in getDays" :key="`7${d7}`">0</td>
            <td v-show="isReady" class="grid-width" v-for="(item, i) in getDemand" :key="i">
              <div :class="item.N[0] > item.N[1] ? 'lack' : 'enough'">{{ item.N[1] }}</div>
            </td>
            <td class="gray-background"></td>
            <td colspan="12">
              <div class="mark rs3"></div>
              <input
                type="text"
                id="3remarkSquare"
                class="mark-explanation"
                v-if="isEdit"
                :value="getRemarkSquare(3)"
                @blur="getRemarkS($event)"
                @keyup.13="$event.target.blur"
              />
              <div
                style="float: left;"
                v-if="!isEdit && (remarkSquareData.length != 0)"
              >{{ getRemarkSquare(3) }}</div>
              <div style="float: left;" v-if="!isEdit && (remarkSquareData.length == 0)">請填寫標誌說明</div>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>
<script>
import Loading from "./Loading.vue";

export default {
  components: {
    Loading,
  },

  data() {
    return {
      year: new Date().getFullYear(),
      month: new Date().getMonth() + 1,
      date: new Date().getDate(),
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
      rsClass: "",
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
  },

  computed: {
    //計算該年該月的天數
    getDays() {
      let tmp = this.year % 4;
      let month_leap = [0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]; //閏年天數
      let month_normal = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]; //非閏年天數

      if (tmp == 0) {
        return month_leap[this.month];
      } else {
        return month_normal[this.month];
      }
    },

    //取得當日人力配置的資料
    getDemand() {
      let real = this.demandData.filter((i) => {
        return (
          i.date.split("-")[0] == this.year &&
          i.date.split("-")[1] == this.month
        );
      });

      return real;
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

      fetch(
        "/api/preresults/?start=" +
          this.year.toString() +
          "-" +
          this.month.toString() +
          "-" +
          "01" +
          "&end=" +
          this.year.toString() +
          "-" +
          this.month.toString() +
          "-" +
          this.getDays.toString()
      )
        .then((res) => {
          return res.json();
        })
        .then((data) => {
          this.preResultData = data;
          //處理懶加載畫面的變數設置
          if (this.preResultData.length != 0) {
            this.isReady = true;
          }
          //紀錄檢核後有問題的班別是否修改的變數設置
          this.preResultData.forEach((i) => {
            i.isModified = false;
          });
        })
        .catch((err) => {
          console.log(err);
        });
    },

    //取得前一個月最後幾天排班資料
    getLastMonthData() {
      fetch(
        "/api/last-month-continue?month_head=" +
          this.year.toString() +
          "-" +
          this.month.toString() +
          "-" +
          "01"
      )
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
      fetch(
        "/api/time-adjustment/?start=" +
          this.year.toString() +
          "-" +
          this.month.toString() +
          "-" +
          "01" +
          "&end=" +
          this.year.toString() +
          "-" +
          this.month.toString() +
          "-" +
          this.getDays.toString()
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
      fetch(
        "/api/total-per-day/?start=" +
          this.year.toString() +
          "-" +
          this.month.toString() +
          "-" +
          "01" +
          "&end=" +
          this.year.toString() +
          "-" +
          this.month.toString() +
          "-" +
          this.getDays.toString()
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
      fetch("/api/shifts")
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

    //----------------------------------------------------

    //-------------------各個function----------------------

    //得出該年該月該日是星期幾
    getDayOfTheWeek(day) {
      let weekday = ["日", "一", "二", "三", "四", "五", "六"];
      let weekofday = new Date(this.month + " " + day + "," + this.year);

      return weekday[weekofday.getDay()];
    },

    //計算該日期是否為今天，如果是今天加上今天的類別(todayMark:true)
    isToday(day) {
      let currentYear = new Date().getFullYear();
      let currentMonth = new Date().getMonth() + 1;
      let currentDate = new Date().getDate();

      if (
        this.year == currentYear &&
        this.month == currentMonth &&
        day == currentDate
      ) {
        return true;
      } else {
        return false;
      }
    },

    // 改變當前月份
    changeMonth(ev) {
      switch (ev.target.id) {
        case "prev":
          this.month--;
          if (this.month < 1) {
            this.year--;
            this.month = 12;
          }
          this.getTotalPerDayData();
          break;
        case "current":
          this.year = new Date().getFullYear();
          this.month = new Date().getMonth() + 1;
          this.getTotalPerDayData();
          break;
        case "next":
          this.month++;
          if (this.month > 12) {
            this.year++;
            this.month = 1;
          }
          this.getTotalPerDayData();
          break;
      }
    },

    //計算該日期是否為今天以前
    isPast(d) {
      let year = new Date().getFullYear();
      let month = new Date().getMonth() + 1;
      let date = new Date().getDate();

      if (d) {
        //當月之前
        if (
          parseInt(d.date.split("-")[1]) < month &&
          parseInt(d.date.split("-")[0]) <= year
        ) {
          return "gray-background";
        } else if (
          parseInt(d.date.split("-")[1]) == month &&
          parseInt(d.date.split("-")[0]) <= year
        ) {
          //當月
          //當日之前
          if (parseInt(d.date.split("-")[2]) < date) {
            return "gray-background";
          } else {
            //當日之後
            return "couldEdit";
          }
        } else {
          //當月之後
          return "couldEdit";
        }
      }
    },

    //利用當年當月當日的日期去PreResult的資料中找到對應的使用者班別資料並回傳
    ShiftOfUser(id, d) {
      let s = this.preResultData.find((userItem) => {
        if (userItem.user == id) {
          return (
            parseInt(userItem.date.split("-")[1]) == this.month &&
            parseInt(userItem.date.split("-")[2]) == d
          );
        }
      });

      if (s != undefined) {
        return s;
      }
    },

    //判斷該班別的樣式
    shiftColor(type) {
      switch (type) {
        case "A":
          return "dayShift";
        case "E":
          return "nightShift";
        case "N":
          return "graveyardShift";
        case "公":
          return "rest";
        case "例":
          return "rest";
        case "休":
          return "rest";
        case "國":
          return "rest";
        case "On":
          return "onCall";
        case "B":
          return "adminis";
        case "補":
          return "restR";
        case "特":
          return "restR";
        case "事":
          return "restR";
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
    isAdjust(data) {
      let obj;
      if (data != undefined) {
        obj = this.adjustHr.find((item) => {
          return item.user == data.user && item.date == data.date;
        });
      }
      if (obj != undefined) {
        if (obj.adjustment_type == 0) {
          return "+" + obj.hours;
        } else if (obj.adjustment_type == 1) {
          return "-" + obj.hours;
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
      let data = {};

      data.content = ev.target.value.toString();
      data.user = id;
      data.month = this.month;

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

      console.log(this.rsClass);
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
    getRemarkS(ev) {
      let data = {};

      data.id = ev.target.id[0];
      data.content = ev.target.value.toString();

      this.remarkS.push(data);
    },

    // editShift(ev) {
    //   console.log(ev.target.parentNode.classList[2]);
    // },
    editShift(ev, info) {
      //加標誌到各筆班別資料
      if (this.rsShow == true && this.rsClass != "") {
        if (ev.target.parentNode.classList[2] == "couldEdit") {
          let data = {};
          data.result = info.id;
          let classListStr = JSON.stringify(ev.target.parentNode.classList);
          ev.target.parentNode.classList.add(this.rsClass);

          if (classListStr.indexOf("rs1") != -1) {
            ev.target.parentNode.classList.remove("rs1");
          } else if (classListStr.indexOf("rs2") != -1) {
            ev.target.parentNode.classList.remove("rs2");
          } else if (classListStr.indexOf("rs3") != -1) {
            ev.target.parentNode.classList.remove("rs3");
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
      }
      if (
        this.isEdit == true &&
        ev.target.parentNode.classList[2] == "couldEdit"
      ) {
        this.singleEdit = true;
        if (info != undefined) {
          this.changeInfo = info;
        }
      } else {
        this.singleEdit = false;
      }
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

    //-------------------------------------------------
  },

  watch: {
    month(newMonth, oldMOnth) {
      this.getUserData();
      this.getPreResults();
      this.getLastMonthData();
      this.getAdjustment();
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
      }

      .couldEdit {
        &:hover {
          cursor: pointer;
        }
      }

      .gray-background {
        background: #f2f2f2 !important;
      }

      .white-background {
        background: white;
      }

      .todayMark {
        border-top: 5px solid #37419a;
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

      .dayShift {
        color: #ebc57c;
      }

      .nightShift {
        color: #84b1ed;
      }

      .graveyardShift {
        color: #6b799e;
      }

      .rest {
        color: #c2c2c2;
      }

      .restR {
        background: #adaaaa;
        color: black;
      }

      .onCall {
        color: #9c8f96;
      }

      .adminis {
        color: #58b4ae;
      }

      .addWork {
        color: #eb8f90;
      }

      .subWork {
        color: #3d313f;
      }

      .remark {
        width: 5rem;
        text-align: center;
      }

      .remark-gird {
        width: 3rem;
        background: #f2f2f2;
        border: none;
        text-align: center;
      }

      .enough {
        color: red;
      }

      .lack {
        color: white;
        background: red;
        width: 100%;
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

      .rs1 {
        border: 5px solid #58b4ae;
      }

      .rs2 {
        border: 5px solid #84b1ed;
      }

      .rs3 {
        border: 5px solid #37419a;
      }

      .mark-explanation {
        border: none;
        float: left;
      }
    }
  }
}
</style>
