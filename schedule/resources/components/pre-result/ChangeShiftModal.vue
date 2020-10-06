<template>
  <div
    class="modal fade"
    id="changeShiftModal"
    tabindex="-1"
    role="dialog"
    aria-hidden="true"
    data-backdrop="static"
  >
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header border-bottom-0">
          <button
            type="button"
            class="close"
            data-dismiss="modal"
            aria-label="Close"
          >
            <span aria-hidden="true">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="24"
                height="24"
                viewBox="0 0 24 24"
              >
                <path
                  d="M24 20.188l-8.315-8.209 8.2-8.282-3.697-3.697-8.212 8.318-8.31-8.203-3.666 3.666 8.321 8.24-8.206 8.313 3.666 3.666 8.237-8.318 8.285 8.203z"
                />
              </svg>
            </span>
          </button>
        </div>
        <div class="modal-body pt-0">
          <h3 class="modal-title rgenda-text-dark-blue mb-4 text-center">
            編輯班表
          </h3>
          <div class="text-left">
            <div class="form-group row">
              <label class="col-sm-4 col-form-label offset-1">類別</label>
              <select class="col-sm-6 form-control" v-model="shiftCategory">
                <option
                  disabled="disabled"
                  style="display: none"
                  value="default"
                ></option>
                <option value="shift">排班</option>
                <option value="holiday">排假</option>
                <option value="adjustment">加班</option>
              </select>
            </div>
            <div class="form-group row" v-if="shiftCategory === 'adjustment'">
              <label class="col-sm-4 col-form-label offset-1">加班選項</label>
              <select class="col-sm-6 form-control" v-model="adjustmentType">
                <option
                  v-for="item in adjustmentTypes"
                  :key="item.id"
                  :value="item"
                >
                  {{ item.name }}
                </option>
              </select>
            </div>
            <div class="form-group row" v-if="shiftCategory !== 'adjustment'">
              <label class="col-sm-4 col-form-label offset-1">項目</label>
              <select
                class="col-sm-6 form-control"
                v-model="newChangeShift.shift"
              >
                <option
                  v-for="item in processedShiftData[shiftCategory]"
                  :key="item.id"
                  :value="item"
                >
                  {{ item.name }}
                </option>
              </select>
            </div>
            <div class="form-group row" v-if="shiftCategory === 'adjustment'">
              <label class="col-sm-4 col-form-label offset-1">班別</label>
              <select class="col-sm-6 form-control" v-model="adjustmentShift">
                <option
                  v-for="item in adjustmentShifts"
                  :key="item.id"
                  :value="item"
                >
                  {{ item.name }}
                </option>
              </select>
            </div>
            <div class="form-group row" v-if="shiftCategory === 'shift'">
              <label class="col-sm-4 col-form-label offset-1">工作站</label>
              <select
                class="col-sm-6 form-control"
                v-model="newChangeShift.station"
              >
                <option
                  v-for="station in stationPicker"
                  :key="station.id"
                  :value="station"
                >
                  {{ station.name }}
                </option>
              </select>
            </div>
            <div class="row">
              <div class="col mb-2 mt-2 text-center">
                <button
                  class="btn btn-rgenda"
                  type="button"
                  data-dismiss="modal"
                >
                  取消
                </button>
                <button
                  id="btn-delete"
                  class="btn btn-rgenda"
                  @click="save()"
                  type="button"
                >
                  儲存
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { PROMISE_LEAVE_ITEM } from "src/promise-leave/constants";
import {
  TIME_ADJUSTMENT_TYPE,
  TIME_ADJUSTMENT_ITEM,
} from "src/time-adjustment/constants";
import { SHIFT_TYPE } from "src/shifts/constants";
export default {
  props: {
    originalShiftData: {
      type: Object,
      default: function () {
        return {
          id: 0,
          user: 0,
          date: "",
          shift: {},
          station: {},
        };
      },
    },
    shiftData: {
      type: Array,
      default: function () {
        return [];
      },
    },
    stationData: {
      type: Array,
      default: function () {
        return [];
      },
    },
    year: {
      type: Number,
      default: 0,
    },
    month: {
      type: Number,
      default: 0,
    },
    workDayHours: {
      type: Number,
      default: 8,
    },
  },
  data() {
    return {
      shiftCategory: "",
      adjustmentShift: -1,
      adjustmentType: null,
      adjustmentTypes: [
        {
          id: TIME_ADJUSTMENT_ITEM.ITEM_OFF_DAY_ATTENDANCE,
          name: this.$getTimeAdjustmentItemText(
            TIME_ADJUSTMENT_ITEM.ITEM_OFF_DAY_ATTENDANCE
          ),
          leaveItemText: this.$getPromiseLeaveItemText(
            PROMISE_LEAVE_ITEM.ITEM_REST_LEAVE
          ),
        },
        {
          id: TIME_ADJUSTMENT_ITEM.ITEM_NATIONAL_HOLIDAY_ATTENDANCE,
          name: this.$getTimeAdjustmentItemText(
            TIME_ADJUSTMENT_ITEM.ITEM_NATIONAL_HOLIDAY_ATTENDANCE
          ),
          leaveItemText: this.$getPromiseLeaveItemText(
            PROMISE_LEAVE_ITEM.ITEM_NATIONAL_HOLIDAY
          ),
        },
        {
          id: TIME_ADJUSTMENT_ITEM.ITEM_EMPTY_SHIFT_ATTENDANCE,
          name: this.$getTimeAdjustmentItemText(
            TIME_ADJUSTMENT_ITEM.ITEM_EMPTY_SHIFT_ATTENDANCE
          ),
          leaveItemText: this.$getPromiseLeaveItemText(
            PROMISE_LEAVE_ITEM.ITEM_EMPTY_SHIFT
          ),
        },
      ],
      newChangeShift: {},
    };
  },
  computed: {
    processedShiftData() {
      let shift = this.shiftData.filter(
        (item) => [0, 1, 2, 4, 7].indexOf(item.shift_type) >= 0
      );
      let holiday = this.shiftData.filter(
        (item) => [3, 5, 6].indexOf(item.shift_type) >= 0
      );

      return {
        default: [],
        shift: shift,
        holiday: holiday,
      };
    },
    adjustmentShifts() {
      return this.shiftData.filter(
        (item) => [0, 1, 2].indexOf(item.shift_type) >= 0
      );
    },
    stationPicker() {
      return this.stationData.filter((i) => {
        return i.name.indexOf("假") === -1;
      });
    },
  },
  methods: {
    save() {
      if (this.shiftCategory === "adjustment") {
        this.newChangeShift.shift = this.shiftData.find(
          (e) => e.name === this.adjustmentType.leaveItemText
        );

        let newAdjustment = {
          user: this.originalShiftData.user,
          date: this.originalShiftData.date,
          hours: this.workDayHours,
          adjustment_type: TIME_ADJUSTMENT_TYPE.TYPE_INCREASE_HOURS,
          adjustment_item: this.adjustmentType.id,
          remark: this.adjustmentShift.shift.name,
        };
        this.$parent.addAdjustment(newAdjustment);
      }
      if (
        [SHIFT_TYPE.VALUE_OFFICIAL_LEAVE, SHIFT_TYPE.VALUE_ADM_SHIFT].indexOf(
          this.newChangeShift.shift.shift_type
        ) >= 0
      ) {
        this.newChangeShift.station = this.stationData.find(
          (i) => i.name === this.originalShiftData.shift.name
        );
      } else if (
        [
          SHIFT_TYPE.VALUE_DAY_SHIFT,
          SHIFT_TYPE.VALUE_NIGHT_SHIFT,
          SHIFT_TYPE.VALUE_GRAVEYARD_SHIFT,
        ].indexOf(this.newChangeShift.shift.shift_type) >= 0
      ) {
        this.newChangeShift.station = this.stationData.find(
          (i) =>
            [
              this.$getShiftTypeText(SHIFT_TYPE.VALUE_OFFICIAL_LEAVE),
              this.$getShiftTypeText(SHIFT_TYPE.VALUE_ADM_SHIFT),
              "休假",
            ].indexOf(i.name) < 0
        );
      } else {
        this.newChangeShift.station = this.stationData.find(
          (i) => i.name === "休假"
        );
      }
      this.$parent.editResult(this.newChangeShift);
      this.shiftCategory = "";
    },
  },
  mounted() {
    this.newChangeShift = {
      id: this.originalShiftData.id,
      user: this.originalShiftData.user,
      date: this.originalShiftData.date,
      shift: this.originalShiftData.shift,
      station: this.originalShiftData.station,
    };
  },
};
</script>
<style>
</style>
