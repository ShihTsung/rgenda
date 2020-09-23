<template>
  <div id="attendance-log" class="mb-4">
    <div class="d-flex">
      <div class="rounded d-flex symbol-square">
      </div>
      <div class="col mb-2 pl-2">
        <h6>出勤記錄</h6>
      </div>
    </div>

    <div class="">
      <vue-good-table :columns="columns" :rows="rows">

        <div slot="emptystate" class="text-center">
          無資料
        </div>
      </vue-good-table>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    schedule: {
      type: Array,
      default: function () {
        return [];
      },
    },
    timeAdjustments: {
      type: Array,
      default: function () {
        return [];
      },
    },
  },
  data() {
    return {
      columns: [
        {
          label: '項目',
          field: 'label',
          sortable: false,
        },
        {
          label: '數量',
          field: 'count',
          type: 'number',
          sortable: false,
        },
        {
          label: '時數小計',
          field: 'hours',
          type: 'number',
          sortable: false,
        },
        {
          label: '說明',
          field: 'description',
          width: '50%',
          sortable: false,
        }
      ],
      rows: [],
    }
  },
  methods: {
    $_attendance_calculateShifts() {
      let shifts = {
        dayShift: {
          id: this.$getShiftTypeValue('VALUE_DAY_SHIFT'),
          label: "白班",
          count: 0,
          hours: 0.0,
          remark: [],
        },
        nightShift: {
          id: this.$getShiftTypeValue('VALUE_NIGHT_SHIFT'),
          label: "小夜",
          count: 0,
          hours: 0.0,
          remark: [],
        },
        graveyardShift: {
          id: this.$getShiftTypeValue('VALUE_GRAVEYARD_SHIFT'),
          label: "大夜",
          count: 0,
          hours: 0.0,
          remark: [],
        },
        onCallShift: {
          id: this.$getShiftTypeValue('VALUE_ON_CALL'),
          label: "On Call",
          count: 0,
          hours: 0.0,
          remark: [],
        },
        admShift: {
          id: this.$getShiftTypeValue('VALUE_ADM_SHIFT'),
          label: "行政",
          count: 0,
          hours: 0.0,
          remark: [],
        },
      };

      this.schedule.forEach((result) => {
        switch (result.shift.shift_type) {
          case shifts.dayShift.id:
            shifts.dayShift.count++;
            shifts.dayShift.hours += result.shift.work_hours;
            break;
          case shifts.nightShift.id:
            shifts.nightShift.count++;
            shifts.nightShift.hours += result.shift.work_hours;
            break;
          case shifts.graveyardShift.id:
            shifts.graveyardShift.count++;
            shifts.graveyardShift.hours += result.shift.work_hours;
            break;
          case shifts.onCallShift.id:
            shifts.onCallShift.count++;
            shifts.onCallShift.hours += result.shift.work_hours;
            shifts.onCallShift.remark.push(`${result.date}，${result.shift.work_hours} 小時`);
            break;
          case shifts.admShift.id:
            shifts.admShift.count++;
            shifts.admShift.hours += result.shift.work_hours;
            break;
        }
      });

      return shifts;
    },
    $_attendance_calculateAttendance() {
      let attendances = {
        workOvertime: {
          id: this.$getTimeAdjustmentItemValue('ITEM_WORK_OVERTIME'),
          label: "工作日加班",
          count: 0,
          hours: 0.0,
          remark: [],
        },
        offDayAttendance: {
          id: this.$getTimeAdjustmentItemValue('ITEM_OFF_DAY_ATTENDANCE'),
          label: "休息日出勤",
          count: 0,
          hours: 0.0,
          remark: [],
        },
        nationalHolidayAttendance: {
          id: this.$getTimeAdjustmentItemValue('ITEM_NATIONAL_HOLIDAY_ATTENDANCE'),
          label: "國定假日出勤",
          count: 0,
          hours: 0.0,
          remark: [],
        },
        emptyShiftAttendance: {
          id: this.$getTimeAdjustmentItemValue('ITEM_EMPTY_SHIFT_ATTENDANCE'),
          label: "空班出勤",
          count: 0,
          hours: 0.0,
          remark: [],
        },
        onCallAttendance: {
          id: this.$getTimeAdjustmentItemValue('ITEM_ON_CALL_ATTENDANCE'),
          label: "On Call 出勤",
          count: 0,
          hours: 0.0,
          remark: [],
        },
        institutionReduceClass: {
          id: this.$getTimeAdjustmentItemValue('ITEM_INSTITUTION_REDUCE_CLASS'),
          label: "機構減班",
          count: 0,
          hours: 0.0,
          remark: [],
        },
        employeeLeave: {
          id: this.$getTimeAdjustmentItemValue('ITEM_EMPLOYEE_LEAVE'),
          label: "員工自假",
          count: 0,
          hours: 0.0,
          remark: [],
        },
      };

      this.timeAdjustments.forEach((adjustment) => {
        switch (adjustment.adjustment_item) {
          case attendances.workOvertime.id:
            attendances.workOvertime.count++;
            attendances.workOvertime.hours += adjustment.hours;
            attendances.workOvertime.remark.push(`${adjustment.date}，${adjustment.hours} 小時，${adjustment.remark}`);
            break;
          case attendances.offDayAttendance.id:
            attendances.offDayAttendance.count++;
            attendances.offDayAttendance.hours += adjustment.hours;
            attendances.offDayAttendance.remark.push(`${adjustment.date}，${adjustment.hours} 小時，${adjustment.remark}`);
            break;
          case attendances.nationalHolidayAttendance.id:
            attendances.nationalHolidayAttendance.count++;
            attendances.nationalHolidayAttendance.hours += adjustment.hours;
            attendances.nationalHolidayAttendance.remark.push(`${adjustment.date}，${adjustment.hours} 小時，${adjustment.remark}`);
            break;
          case attendances.emptyShiftAttendance.id:
            attendances.emptyShiftAttendance.count++;
            attendances.emptyShiftAttendance.hours += adjustment.hours;
            attendances.emptyShiftAttendance.remark.push(`${adjustment.date}，${adjustment.hours} 小時，${adjustment.remark}`);
            break;
          case attendances.onCallAttendance.id:
            attendances.onCallAttendance.count++;
            attendances.onCallAttendance.hours += adjustment.hours;
            attendances.onCallAttendance.remark.push(`${adjustment.date}，${adjustment.hours} 小時，${adjustment.remark}`);
            break;
          case attendances.institutionReduceClass.id:
            attendances.institutionReduceClass.count++;
            attendances.institutionReduceClass.hours += adjustment.hours;
            attendances.institutionReduceClass.remark.push(`${adjustment.date}，${adjustment.hours} 小時，${adjustment.remark}`);
            break;
          case attendances.employeeLeave.id:
            attendances.employeeLeave.count++;
            attendances.employeeLeave.hours += adjustment.hours;
            attendances.employeeLeave.remark.push(`${adjustment.date}，${adjustment.hours} 小時，${adjustment.remark}`);
            break;
        }
      });

      return attendances;
    },
    calculate() {
      let shifts = this.$_attendance_calculateShifts();
      let attendances = this.$_attendance_calculateAttendance();
      let merged = Object.assign(shifts, attendances);
      let arr = [];
      Object.keys(merged).map((key) => {
        if (merged[key].hours > 0) {
          arr.push({
            id: merged[key].id,
            label: merged[key].label,
            count: merged[key].count,
            hours: merged[key].hours,
            description: merged[key].remark.join('<br>'),
          });
        }
      });
      console.log(arr)
      this.rows = arr;
    },
  },
  watch: {
    schedule(newVal, oldVal) {
      if (newVal.length > 0 && newVal != oldVal) {
        this.calculate();
      }
    },
  },
}
</script>
