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
                <path d="M24 20.188l-8.315-8.209 8.2-8.282-3.697-3.697-8.212 8.318-8.31-8.203-3.666 3.666 8.321 8.24-8.206 8.313 3.666 3.666 8.237-8.318 8.285 8.203z" />
              </svg>
            </span>
          </button>
        </div>
        <div class="modal-body pt-0">
          <h3 class="modal-title rgenda-text-dark-blue mb-4 text-center">編輯班表</h3>
          <div class="text-left">
            <div class="form-group row">
              <label class="col-sm-4 col-form-label offset-1">類別</label>
              <select class="col-sm-6 form-control" v-model="shiftCategory">
                <option disabled="disabled" style="display: none" value="default"></option>
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
                >{{item.name}}</option>
              </select>
            </div>
            <div class="form-group row" v-if="shiftCategory !== 'adjustment'">
              <label class="col-sm-4 col-form-label offset-1">項目</label>
              <select class="col-sm-6 form-control" v-model="changeShift.shift">
                <option
                  v-for="item in processedShiftData[shiftCategory]"
                  :key="item.id"
                  :value="item"
                >{{item.name}}</option>
              </select>
            </div>
            <div class="form-group row" v-if="shiftCategory === 'adjustment'">
              <label class="col-sm-4 col-form-label offset-1">班別</label>
              <select class="col-sm-6 form-control" v-model="adjustmentShift">
                <option
                  v-for="item in adjustmentShifts"
                  :key="item.id"
                  :value="item"
                >{{item.name}}</option>
              </select>
            </div>
            <div class="form-group row" v-if="shiftCategory === 'shift'">
              <label class="col-sm-4 col-form-label offset-1">工作站</label>
              <select class="col-sm-6 form-control" v-model="changeShift.station">
                <option
                  v-for="station in stationPicker"
                  :key="station.id"
                  :value="station"
                >{{station.name}}</option>
              </select>
            </div>
            <div class="row">
              <div class="col mb-2 mt-2 text-center">
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
          user: 0,
          date: '',
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
    stationPicker: {
      type: Array,
      default: function () {
        return [];
      },
    },
    year: {
      type: Number,
      default: 0
    },
    month: {
      type: Number,
      default: 0
    }

  },
  data() {
    return {
      shiftCategory: '',
      adjustmentShift: -1,
      adjustmentType: -1
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
    adjustmentTypes(){
      return [
        {
          id: 0,
          name: "休息日出勤"
        },
        {
          id: 1,
          name: "國定假日出勤"
        },
        {
          id: 2,
          name: "空班出勤"
        }
      ]
    },
    adjustmentShifts(){
      return this.shiftData.filter(
        (item) => [0, 1, 2].indexOf(item.shift_type) >= 0
      );
    }

  },
  methods: {
    save() {
      if (this.shiftCategory !== 'adjustment'){
        this.shiftCategory = '';
        this.$parent.editResult(this.changeShift);
      }else{
        let new_changeShift = {
          id: this.changeShift.id,
          user: this.changeShift.user,
          date: this.changeShift.date,
          shift: null,
          station: this.changeShift.station,
        }
        switch(this.adjustmentType.id){
          case 0:
            new_changeShift['shift'] = this.shiftData.filter(
              e=>e.name=='休息')[0];
            break;
          case 1:
            new_changeShift['shift'] = this.shiftData.filter(
              e=>e.name=='國定假日')[0];
            break;
          case 2:
            new_changeShift['shift'] = this.shiftData.filter(
              e=>e.name=='空班')[0];
        }
        this.shiftCategory = '';
        this.$parent.editResult(new_changeShift);
        let new_adjustment = {
          user: this.changeShift.user,
          date: this.changeShift.date,
          hours: 8,
          adjustment_type: 0,
          adjustment_item: this.adjustmentType.id,
          remark: null
        }
        switch(this.adjustmentShift.shift_type){
          case 0:
            new_adjustment['remark'] = '白班';
            break;
          case 1:
            new_adjustment['remark'] = '小夜';
            break;
          case 2:
            new_adjustment['remark'] = '大夜';
        }
        this.$parent.addAdjustment(new_adjustment);
      }

    },

  },
};
</script>

<style>
</style>
