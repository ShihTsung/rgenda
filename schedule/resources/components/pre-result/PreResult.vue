<template>
  <div id="pre-result" v-cloak>
    <loading v-show="showLoading" :text="text"></loading>
    <check-pass></check-pass>
    <div id="top-info">
      <div class="time">
        <h2 class="year">{{year}}年</h2>
        <h2 class="month">&nbsp;{{month}}月</h2>
      </div>

      <div class="bt-group">
        <div class="icon-bts float-right" data-tooltip="tooltip" title="列印"
        @click="printHtml"
        >
          <svg class="icon-color" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path d="M24 5h-4v-5h-16v5h-4v13h4v6h9.519c2.947 0 6.029-3.577 6.434-6h4.047v-13zm-18-3h12v3h-12v-3zm8.691 16.648s1.469 3.352-2 3.352h-6.691v-8h12v2.648c0 3.594-3.309 2-3.309 2zm6.809-10.648c-.276 0-.5-.224-.5-.5s.224-.5.5-.5.5.224.5.5-.224.5-.5.5zm-5.5 9h-8v-1h8v1zm-3 1h-5v1h5v-1z"/></svg>
        </div>
        <div class="add-sub-wrapper" @click="changeMonth($event)">
          <div id="prev" class="icon-bts border-0 m-0 px-0" data-tooltip="tooltip" title="上個月">
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
          <div id="next" class="icon-bts border-0 m-0 px-0" data-tooltip="tooltip" title="下個月">
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
            @followshiftedit="sendFollowShift(data)"
          >
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
          <div
            class="icon-bts check-btn"
            data-tooltip="tooltip"
            title="檢核"
            @click="getCheckResultData()"
            :style="{cursor: couldCheck()}"
          >
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
          <div
            class="icon-bts announce-btn"
            data-tooltip="tooltip"
            title="發佈"
            @click="publishModal()"
          >
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
        <div
          class="icon-bts float-right"
          data-tooltip="tooltip"
          title="輔助線"
          @click="toggleCross">
          <svg class="icon-color" xmlns="http://www.w3.org/2000/svg"
            width="24" height="24" viewBox="0 0 24 24">
            <path d="M24 11h-2.051c-.469-4.725-4.224-8.48-8.949-8.95v-2.05h-2v2.05c-4.725.47-8.48 4.225-8.949 8.95h-2.051v2h2.051c.469 4.725 4.224 8.48 8.949 8.95v2.05h2v-2.05c4.725-.469 8.48-4.225 8.949-8.95h2.051v-2zm-11 8.931v-3.931h-2v3.931c-3.611-.454-6.478-3.32-6.931-6.931h3.931v-2h-3.931c.453-3.611 3.32-6.477 6.931-6.931v3.931h2v-3.931c3.611.454 6.478 3.319 6.931 6.931h-3.931v2h3.931c-.453 3.611-3.32 6.477-6.931 6.931zm1-7.931c0 1.104-.896 2-2 2s-2-.896-2-2 .896-2 2-2 2 .896 2 2z"/>
          </svg>
        </div>
      </div>
    </div>
    <div id="print-result" class="calendar">
      <table
        class="master-schedule-table"
        border="1"
        cellspacing="0"
        bordercolor="#b2b2b2"
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
              :adjustmentRemark="getAdjustmentRemark(u.id, dd)"
              :triangle="userReserve(u.id, month, dd)"
              :checkContent="checkPreResult(u.id, dd)"
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
    <change-shift-modal
      :changeShift="changeInfo"
      :shiftData="shiftData"
      :stationPicker="stationPicker"
      :year="year"
      :month="month"
      v-if="!rsShow && isEdit"
    ></change-shift-modal>

    <follow-shift-modal
      :userData="userData"
      :follower="follower"
      :getDays="getDays"
      :year="year"
      :month="month"></follow-shift-modal>

    <recalculate-modal :year="year" :month="month" :getDays="getDays" v-show="couldRecalculate"></recalculate-modal>
    <error-alert-modal v-show="!couldRecalculate"></error-alert-modal>
    <publish-modal :year="year" :month="month" :status.sync="publishStatus" :isCheck.sync="isCheck"></publish-modal>
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
import PublishModal from "./PublishModal.vue";
import CheckPass from "./CheckPass.vue";
import printJS from 'print-js';
import popup from 'common/popup';
import browser from 'common/browser';

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
    PublishModal,
    CheckPass,
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
      newAdjustmentList: [],
    };
  },

  mounted() {
    this.$httpClient.get("/api/users/curr/").then((res) => {
      this.user = res.data;
      Promise.all([
        this.getUserData().then(() => {
          return this.getPreResults();
        }),
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
      return fetch(`/api/user-resource?year=${this.year}&month=${this.month}&rset=preresult`)
        .then((res) => {
          return res.json();
        })
        .then((data) => {
          data.sort(function (a, b) {
            return a.sort - b.sort;
          });
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
        `/api/preresults/?start=${this.year}-${this.month}-01&end=${this.year}-${this.month}-${this.getDays}`
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
              if (moment(i.date).month() + 1 === this.month && this.userData.find((u) => u.id == i.user)) {
                if (!processedShifts[i.user]) {
                  processedShifts[i.user] = {};
                }
                let date = moment(i.date).date();

                //紀錄檢核後有問題的班別是否修改的變數設置
                i.isModified = false;
                processedShifts[i.user][date] = i;
              }
            });
          }
          this.isReady = true;
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
        if (this.month < month || (this.month === month && day <= today)) {
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
            item.user == u && (
              parseInt(item.date.split("-")[1]) < month || (
                parseInt(item.date.split("-")[1]) === month &&
                parseInt(item.date.split("-")[2]) <= today
              )
            )
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

      this.adjustHr
        .forEach((i) => {
          if (
            i.user == u &&
            parseInt(i.date.split("-")[1]) === this.month && (
              this.$getTimeAdjustmentItemValue('ITEM_OFF_DAY_ATTENDANCE') === i.adjustment_item ||
              this.$getTimeAdjustmentItemValue('ITEM_NATIONAL_HOLIDAY_ATTENDANCE') === i.adjustment_item
            )
          ) {
            ++noRest;
          }
        });

      this.promiseData.forEach((item) => {
        let day = parseInt(item.date.split("-")[2]);
        let shiftType;
        if (this.$getPromiseLeaveCategoryValue("PAID_LEAVE") == this.$getPromiseLeaveCategoryByItemValue(item.shift_type)) {
          shiftType = this.$getShiftTypeValue("VALUE_PAID_LEAVE");
        } else {
          shiftType = this.$getShiftTypeValue("VALUE_UNPAID_LEAVE");
        }
        // 只有當
        // 1. 當日無預排結果
        // 2. 預排結果與預約假勤不同
        // 時才計算，不重複計算假日，且排除公假
        if (
          item.user.id === u &&
          (
            !this.shiftOfCurrentMonth[u] ||
            !this.shiftOfCurrentMonth[u][day] ||
            this.shiftOfCurrentMonth[u][day].shift.shift_type !== shiftType &&
            item.shift_type !== this.$getPromiseLeaveItemValue('ITEM_OFFICIAL_LEAVE')
          )
        ) {
          if (shiftType === this.$getShiftTypeValue("VALUE_PAID_LEAVE")) {
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
        case 5: // 實際Off = 例休國 + 有薪假 + 無薪假 - 加班「休假出勤」、「國定假日出勤」
          return (special + count + notCount - noRest);
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

        this.getDemandList();
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
      this.getDemandList();
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

      return Boolean(found);
    },

    async sendToResults() {
      this.followEdit = false;
      this.rsShow = false;
      this.isSave = true;

      let promises = [];

      await this.changedResult.forEach((i) => {
        let data = {
          user: i.user,
          shift: i.shift.id,
          date: i.date,
          station: i.station ? i.station.id : null,
        };
        let promise;
        if (!i.id) {
          promise = fetch("/api/preresults/", {
            headers: {
              "X-CSRFToken": this.csrfToken,
              "content-type": "application/json",
            },
            body: JSON.stringify(data),
            method: "POST",
          })
          .then(res=>{
            console.log(res);
          })
          .catch((err) => {
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

      this.userRemarks.forEach((i) => {
        //檢查remarkData中有沒有資料
        let check = this.userRemarkData.find((item) => {
          return item.month == this.month && item.user == i.user;
        });

        let promise;
        //remarkData有資料
        if (check) {
          promise = fetch(`/api/user-remarks/${check.id}/`, {
            headers: {
              "X-CSRFToken": `${this.csrfToken}`,
              "content-type": "application/json",
            },
            body: JSON.stringify(i),
            method: "PATCH",
          }).catch((err) => {
            console.log(err);
          });
        } else {
          //remarkData沒資料
          promise = fetch("/api/user-remarks/", {
            headers: {
              "X-CSRFToken": `${this.csrfToken}`,
              "content-type": "application/json",
            },
            body: JSON.stringify(i),
            method: "POST",
          }).catch((err) => {
            console.log(err);
          });
        }
        promises.push(promise);
      });

      //正方形標誌說明
      this.remarkSquare.forEach((item) => {
        let promise;
        if (this.remarkSquareData[item.index]) {
          let data = this.remarkSquareData[item.index];
          promise = fetch(`/api/remark-squares/${data.id}/`, {
            headers: {
              "X-CSRFToken": `${this.csrfToken}`,
              "content-type": "application/json",
            },
            body: JSON.stringify(item),
            method: "PATCH",
          }).catch((err) => {
            console.log(err);
          });
        } else {
          promise = fetch("/api/remark-squares/", {
            headers: {
              "X-CSRFToken": `${this.csrfToken}`,
              "content-type": "application/json",
            },
            body: JSON.stringify(item),
            method: "POST",
          }).catch((err) => {
            console.log(err);
          });
        }
        promises.push(promise);
      });

      //每個使用者每天是否有正方形標誌
      this.resultRS.forEach((i) => {
        let check = this.preResultRemarkData.find((item) => {
          return i.result == item.result;
        });

        let promise;
        if (check) {
          promise = fetch(`/api/preresult-remarks/${check.id}/`, {
            headers: {
              "X-CSRFToken": `${this.csrfToken}`,
              "content-type": "application/json",
            },
            body: JSON.stringify(i),
            method: "PATCH",
          }).catch((err) => {
            console.log(err);
          });
        } else {
          promise = fetch("/api/preresult-remarks/", {
            headers: {
              "X-CSRFToken": `${this.csrfToken}`,
              "content-type": "application/json",
            },
            body: JSON.stringify(i),
            method: "POST",
          }).catch((err) => {
            console.log(err);
          });
        }
        promises.push(promise);
      });
        // 送出加班資料
      this.newAdjustmentList.forEach(e=>{
        let promise;
        let config = {
                headers: {
                  "X-CSRFToken": `${this.csrfToken}`,
                  "content-type": "application/json",
                },
              };
        promise = this.$httpClient.post("/api/time-adjustment/", e, config).then(res=>{
            console.log(res);
          })
          .catch(err=>{
            console.log(err);
          })
        promises.push(promise);
      })

      Promise.all(promises).then(() => {
        this.getAdjustment();
        this.getPreResults();
        this.getUserRemark();
        this.getRemarkSquareData();
        this.getPreResultRemarkData();
      });

      this.changedResult.length = 0;
      this.userRemarks.length = 0;
      this.remarkSquare.length = 0;
      this.resultRS.length = 0;
      this.newAdjustmentList.length = 0;
      this.isEdit = false;
      this.isCheck = false;
    },

    //控制重算或者錯誤的小視窗
    callResetModal() {
      this.$httpClient
        .get(`/api/published-or-not?year=${this.year}&month=${this.month}`)
        .then((response) => {
          this.couldRecalculate = response.data ? false : true;
        })
        .then(() => {
          this.couldRecalculate === true
            ? $("#recalculateModal").modal("show")
            : $("#errorAlertModal").modal("show");
        })
        .catch((err) => {
          console.log(err);
        });
    },

    publishModal() {
      if (this.isCheck) {
        this.publishStatus = 1;
      }
      $("#publishModal").modal("show");
    },

    checkPreResult(user, date) {
      let content = this.checkResultData.find((item) => {
        if (
          this.shiftOfCurrentMonth[user] &&
          this.shiftOfCurrentMonth[user][date]
        ) {
          return this.shiftOfCurrentMonth[user][date].id === item.id;
        }
      });
      if (content) {
        return content;
      }
    },

    couldCheck() {
      if(this.isSave== true) {
          return 'pointer';
        }else {
          return 'not-allowed';
        }
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
          if (!demandList[day - 1]) {
            demandList[day - 1] = {
              D: [],
              E: [],
              N: [],
            };
          }
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
    printHtml() {
      if (!(browser.isChrome() || browser.isEdge())) {
        popup.warning({
          title: '不支援的瀏覽器',
          text: '此功能僅支援最新版的 Google Chrome/ Microsoft Edge 瀏覽器',
        });

        return;
      }

      new Promise((resolve) => {
        popup.loading({
          title: '列印準備中...',
        });
        setTimeout(function () {
          resolve();
        }, 100);
      }).then(() => {
        let target = document.getElementById('print-result').cloneNode(true);
        target.setAttribute('id', 'printTarget');
        target.classList.add('print');

        let iframe = document.createElement('iframe');
        iframe.setAttribute('style', 'visibility: ; height: 100vh; width: 100vw; position: absolute; border: 0; z-index: -999');
        iframe.setAttribute('id', 'prePrint');
        iframe.appendChild(target);
        document.body.appendChild(iframe);

        printJS({
          printable: 'printTarget',
          type: 'html',
          targetStyles: '*',
          maxWidth: 1320,
          header: `${this.year}年${this.month}月`,
          onPrintDialogClose: function () {
            popup.close();
            iframe.remove();
            document.getElementById('printJS').remove();
          },
        });
      });
    },
    //加入加班資料, 儲存時才送出
    addAdjustment(adjInfo){
      this.newAdjustmentList.push(adjInfo);
      this.adjustHr.push(adjInfo);
    },
    toggleCross(){
      let ox = document.getElementById('ox');
      let oy = document.getElementById('oy');
      ox.classList.toggle('hide');
      oy.classList.toggle('hide');
    },
    reloadData() {
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
      this.getPreResultRemarkData();
      this.getUserRemark();
    },
  },

  watch: {
    month() {
      this.reloadData();
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
      padding: 10px 50px;

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

  /** for print **/
  .print.calendar {
    position: absolute;
    top: 0;
    left: 0;
    height: auto;
    overflow: auto;
    padding-bottom: 100px;
  }
}
</style>
