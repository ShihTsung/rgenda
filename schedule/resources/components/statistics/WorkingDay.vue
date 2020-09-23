<template>
  <div>
    <div class="d-flex">
      <div class="rounded d-flex symbol-square">
      </div>
      <div class="col mb-2 pl-2">
        <h6>本月出勤/不出勤日數</h6>
      </div>
    </div>

    <div class="container-fluid border rounded">
      <template v-if="schedule.length > 1">
        <div class="from-group row" v-for="(date, index) in dates"
        :key="['working-day', index].join('_')">
          <label class="col-sm-2 col-form-label">{{ date.label }}</label>
          <div class="col-sm-10">{{ date.number}} 天</div>
        </div>
      </template>
      <template v-else>
        <div class="text-center"><p class="form-control-plaintext">無資料</p></div>
      </template>
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
  },
  data() {
    return {
      dates: null,
    }
  },
  methods: {
    calculate() {
      let dates = {
        work: {
          label: "工作日",
          number: 0,
        },
        restLeave: {
          label: "休息日",
          number: 0,
        },
        officialHoliday: {
          label: "例假日",
          number: 0,
        },
        nationalHoliday: {
          label: "國定假日",
          number: 0,
        },
        annualLeave: {
          label: "特休",
          number: 0,
        },
      };

      this.schedule.forEach((result) => {
        if (this.$isWorkShift(result.shift.shift_type)) {
          dates.work.number++;
        } else {
          let leaveItem = this.$getPromiseLeaveItemByText(result.shift.name);
          if (leaveItem) {
            switch (leaveItem.id) {
              case this.$getPromiseLeaveItemValue("ITEM_REST_LEAVE"):
                dates.restLeave.number++;
                break;
              case this.$getPromiseLeaveItemValue("ITEM_OFFICIAL_HOLIDAY"):
                dates.officialHoliday.number++;
                break;
              case this.$getPromiseLeaveItemValue("ITEM_NATIONAL_HOLIDAY"):
                dates.nationalHoliday.number++;
                break;
              case this.$getPromiseLeaveItemValue("ITEM_ANNUAL_LEAVE"):
                dates.annualLeave.number++;
                break;
            }
          }
        }
      });

      this.dates = dates;
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

<style scoped>

</style>
