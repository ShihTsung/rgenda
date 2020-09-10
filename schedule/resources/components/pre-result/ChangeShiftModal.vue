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
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">
              <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
                <path
                  d="M24 20.188l-8.315-8.209 8.2-8.282-3.697-3.697-8.212 8.318-8.31-8.203-3.666 3.666 8.321 8.24-8.206 8.313 3.666 3.666 8.237-8.318 8.285 8.203z"
                />
              </svg>
            </span>
          </button>
        </div>
        <div class="modal-body text-center pt-0">
          <h3 class="modal-title rgenda-text-dark-blue mb-4">編輯班表</h3>
          <div class="container-fluid text-left">
            <div class="form-group">
              <label class="font-weight-bold">類別</label>
              <select v-model="shiftCategory">
                <option disabled="disabled" style="display: none" value="default"></option>
                <option value="shift">排班</option>
                <option value="holiday">排假</option>
              </select>
            </div>
            <div class="form-group">
              <label class="font-weight-bold">項目</label>
              <select v-model="changeShift.shiftId">
                <option disabled="disabled" style="display: none" :value="-1"></option>
                <option
                  v-for="item in processedShiftData[shiftCategory]"
                  :key="item"
                  :value="item.id"
                >{{item.name}}</option>
              </select>
            </div>
            <div class="form-group" v-if="shiftCategory === 'shift'">
              <label class="font-weight-bold">工作站</label>
              <select v-model="changeShift.stationId">
                <option disabled="disabled" style="display: none" value></option>
                <option
                  v-for="station in stationPicker"
                  :key="station"
                  :value="station.id"
                >{{station.name}}</option>
              </select>
            </div>
            <div class="row">
              <div class="col mb-2 text-center">
                <button class="btn btn-rgenda" type="button" data-dismiss="modal">取消</button>
                <button id="btn-delete" class="btn btn-rgenda" @click="save()" type="button">儲存</button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    changeShift: {
      type: Object,
      default: function () {
        return {
          id: 0,
          userId: 0,
          date: '',
          shiftId: -1,
          stationId: -1,
        };
      },
    },
    shiftData: {
      type: Array,
      default: function () {
        return [];
      },
    },
    stationPicker: {
      type: Array,
      default: function () {
        return [];
      },
    },
  },
  data() {
    return {
      subcategories: [],
    };
  },
  computed: {
    processedShiftData() {
      let shift = this.shiftData.filter(
        (item) => [0, 1, 2, 4].indexOf(item.shift_type) >= 0
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
  },
  methods: {
    save() {
      this.$parent.editResult(this.changeShift);
    },
  },
};
</script>

<style>
</style>
