<template>
  <full-calendar id="calendar" :options="calendarOptions"></full-calendar>
</template>

<script>
import FullCalendar from "@fullcalendar/vue";
import dayGridPlugin from "@fullcalendar/daygrid";
import { shiftColor, adjustColor } from "src/constants/color";
import { getShiftTimeStr } from "src/exchange/util";

export default {
  components: {
    FullCalendar,
  },
  data() {
    return {
      calendarOptions: {
        locale: "zh-TW",
        plugins: [dayGridPlugin],
        editable: false,
        themeSystem: "bootstrap",
        firstDay: 0,
        timeZone: "UTC",
        headerToolbar: {
          left: "prev",
          center: "title",
          right: "next",
        },
        showNonCurrentDates: false,
        droppable: true,
        views: {
          dayGridMonth: {
            titleFormat: { year: "numeric", month: "2-digit" },
          },
        },
        eventOrder: "sort,title",
        eventDidMount: this.renderEvents,
        events: this.getEvents,
      },
      department: null,
      shiftsPromise: this.getShifts(),
      stationsPromise: this.getStations(),
      currentUserPromise: this.getCurrentUser(),
    };
  },
  methods: {
    getShiftTimeStr,
    getEvents(fetchInfo, successCallback) {
      const queryString =
        "?mode=personal&start=" +
        fetchInfo.startStr +
        "&end=" +
        fetchInfo.endStr;

      let resultPromise = Promise.all([
        this.$httpClient.get("/api/results/" + queryString),
        this.shiftsPromise,
        this.stationsPromise,
        this.$httpClient.get("/api/dates/" + queryString),
      ]).then(this.processResult);

      let timeAdjustmentPromise = Promise.all([
        this.$httpClient.get("/api/time-adjustment/" + queryString),
        this.currentUserPromise,
      ]).then(this.processTimeAdjustment);

      let promisesPromise = this.currentUserPromise.then((response) => {
        return this.$httpClient
          .get("/api/promises/" + queryString + "&uid=" + response.data.id)
          .then(this.processPromises);
      });

      let reservationsPromise = this.$httpClient
        .get("/api/reservations/" + queryString)
        .then(this.processReservations);

      Promise.all([
        resultPromise,
        timeAdjustmentPromise,
        promisesPromise,
        reservationsPromise,
      ]).then((responses) => {
        // flatten array of arrays
        // ref: https://stackoverflow.com/questions/10865025/merge-flatten-an-array-of-arrays
        let allData = [].concat.apply([], responses);
        successCallback(allData);
      });
    },
    getShifts() {
      return this.$httpClient.get("/api/shifts/?all=true");
    },
    getStations() {
      return this.$httpClient.get("/api/stations/");
    },
    getCurrentUser() {
      return this.$httpClient.get("/api/users/curr/");
    },
    processResult(responses) {
      const data = responses[0].data;
      const shifts = responses[1].data;
      const stations = responses[2].data;
      const dates = responses[3].data;

      if (!data || data.length === 0) {
        return [];
      }
      data.forEach((e) => {
        const shift = shifts.find((i) => i.id === e.shift.id);
        const station = stations.find((i) => i.id === e.station.id);
        const date = dates.find((i) => i.start === e.date);
        if (date.attribute[shift.department.id] === "0") {
          e.title = "單科休診";
          e.sort = 1;
          e.isOff = true;
          e.backgroundColor = "#ffffff";
          e.borderColor = shiftColor.default;
          e.textColor = shiftColor.default;
        } else {
          e.resourceId = e.user.id;
          e.shift = shift;
          e.station = station;
          if ([3, 5, 6].indexOf(shift.shift_type) < 0) {
            e.sort = 1;
          } else {
            e.title = shift.name;
            e.isOff = true;
            e.sort = 3;
          }
          const color = shiftColor.hasOwnProperty(shift.shift_type)
            ? shiftColor[shift.shift_type]
            : shiftColor.default;
          if (
            [0, 1, 2, 4, 7].indexOf(shift.shift_type) >= 0 ||
            e.shift_type === "空"
          ) {
            e.className = "shift-type-cell";
            e.backgroundColor = color;
            e.borderColor = color;
            e.textColor = color;
          } else {
            e.backgroundColor = "#ffffff";
            e.borderColor = color;
            e.textColor = color;
          }
        }
      });
      return data;
    },
    processTimeAdjustment(responses) {
      const data = responses[0].data;
      const user = responses[1].data;

      if (!data || data.length === 0) {
        return [];
      }

      let processedData = [];
      data.forEach((e) => {
        if (e.user === user.id) {
          e.title = (e.adjustment_type === 0 ? "+" : "-") + e.hours;
          e.sort = 2;
          e.resourceId = e.user;
          e.className = "adjust-hours";
          e.backgroundColor = adjustColor[e.adjustment_type];
          e.borderColor = adjustColor[e.adjustment_type];
          e.textColor = adjustColor[e.adjustment_type];
          processedData.push(e);
        }
      });
      return processedData;
    },
    processPromises(response) {
      if (!response.data || response.data.length === 0) {
        return [];
      }

      let processedData = [];
      response.data.forEach((e) => {
        e.title = "預約" + this.$getPromiseLeaveItemText(e.shift_type);
        e.resourceId = e.user.id;
        e.sort = 4;
        e.backgroundColor = "#ffffff";
        e.borderColor = shiftColor.default;
        e.textColor = shiftColor.default;
        processedData.push(e);
      });
      return processedData;
    },
    processReservations(response) {
      response.data.forEach((e) => {
        e.title = "預約休假";
        e.resourceId = e.user.id;
        e.sort = 4;
        e.backgroundColor = "#ffffff";
        e.borderColor = shiftColor.default;
        e.textColor = shiftColor.default;
      });
      return response.data;
    },
    renderEvents(info) {
      if (
        info.event.extendedProps.hasOwnProperty("shift") &&
        info.event.extendedProps.isOff !== true
      ) {
        let shiftType = document.createElement("span");
        shiftType.innerHTML = info.event.extendedProps.shift_type;
        shiftType.className = "shift-type";

        let shiftTime = document.createElement("span");
        shiftTime.innerHTML = this.getShiftTimeStr(
          info.event.extendedProps.shift
        );
        shiftTime.className = "shift-time";

        let shiftStation = document.createElement("span");
        shiftStation.innerHTML = info.event.extendedProps.station.name;
        shiftStation.className = "shift-station";

        $(info.el)
          .find(".fc-event-title-container")
          .empty()
          .append(shiftType)
          .append(shiftTime)
          .append(shiftStation);
      } else if (info.event.extendedProps.hasOwnProperty("adjustment_type")) {
        if (info.event.extendedProps.remark) {
          let adjustItem = document.createElement("span");
          adjustItem.innerHTML = info.event.extendedProps.remark;
          adjustItem.className = "adjust-item";
          $(info.el).find(".fc-event-title-container").append(adjustItem);
        }
      }
    },
    setStartOfWeek() {
      this.$httpClient.get("/api/departments/").then((response) => {
        this.department = response.data;
        if (
          response.data &&
          response.data[0] &&
          !isNaN(response.data[0].start_of_week)
        ) {
          this.$set(
            this.calendarOptions,
            "firstDay",
            response.data[0].start_of_week
          );
        }
      });
    },
  },
  mounted() {
    this.setStartOfWeek();
  },
};
</script>

<style scoped>
#calendar {
  background-color: white !important;
  padding: 2rem;
  max-width: 1140px;
  margin: 20px auto;
}

.fc-event {
  display: inline-block;
  width: 90%;
  height: 24px;
  border-radius: 3px;
  border: 1px solid;
  text-align: left;
}

::v-deep .shift-type-cell .fc-event-title,
::v-deep .adjust-hours .fc-event-title {
  color: white !important;
  vertical-align: top;
}

.fc-title {
  font-size: 16px;
  margin: auto 4px;
}

::v-deep .shift-type-cell .shift-time,
::v-deep .shift-type-cell .shift-station,
::v-deep .shift-type-cell .adjust-item {
  top: 0px;
  font-size: 12px;
  background: white;
  margin: auto 1px;
  padding: 1px;
  border-radius: 3px;
}

.day_type {
  display: inline-block;
  color: white;
  margin-left: 2px;
  font-weight: 400;
  float: left;
  /* margin-top: -2px; */
}

.day_content {
  display: inline-block;
  background: white;
  height: 20px;
  width: 40px;
  color: #ebc57c;
  border-radius: 3px;
  float: left;
  margin-left: 15px;
  /* margin-top: 2px; */
  font-size: 12px;
  line-height: 20px;
  padding-left: 2px;
}

.fc-unthemed .fc-content,
.fc-unthemed .fc-divider,
.fc-unthemed .fc-list-heading td,
.fc-unthemed .fc-list-view,
.fc-unthemed .fc-popover,
.fc-unthemed .fc-row,
.fc-unthemed tbody,
.fc-unthemed td,
.fc-unthemed th,
.fc-unthemed thead {
  border-color: #c8c8c8;
}

.fc-unthemed .fc-disabled-day {
  background: #f1f1f1;
  opacity: 1;
}

.fc-past {
  background: white;
}

.fc-future {
  background: white;
}

h2 {
  display: inline-block;
}

.fc-button-primary {
  color: black;
  background: none;
  border: none;
}

.fc-prev-button {
  position: absolute;
  left: 380px;
}

.fc-next-button {
  position: absolute;
  right: 380px;
}

table {
  text-align: center;
  border: 1px solid #c6c6c6;
}

th {
  background-color: #d9d9d9;
}

.audit_items_body {
  background: white;
}

.last_one {
  color: #b5b5b5;
  font-weight: 300;
  font-size: 13px;
}

.ex-wrapper {
  margin-top: 5px;
  height: 28px;
}

#origin_schedule {
  display: inline-block;
  width: 135px;
  height: 24px;
  background: #ebc57c;
  border-radius: 3px;
}

.os_title {
  display: inline-block;
  color: white;
  margin-left: 5px;
  font-weight: 400;
  float: left;
  margin-top: -2px;
}

.os_content {
  display: inline-block;
  background: white;
  height: 20px;
  width: 45px;
  color: #ebc57c;
  border-radius: 3px;
  float: left;
  margin-left: 5px;
  margin-top: 2px;
  font-size: 12px;
  line-height: 20px;
  padding-left: 2px;
}

#top {
  background: #eee;
  border-bottom: 1px solid #ddd;
  padding: 0 10px;
  line-height: 40px;
  font-size: 12px;
}

.container {
  width: 100%;
}

.fc-event-container {
  color: white;
}

/* i {
            font-size: 30px;
        } */
/* .card-body {
            color: black;
            font-size: 1.2rem;
            text-decoration: none;
            text-overflow: hide;
        } */
.dash {
  width: 100%;
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  flex-wrap: nowrap;
  margin-bottom: 2rem;
}

.calendar {
  width: 100%;
  height: 50%;
}
</style>
