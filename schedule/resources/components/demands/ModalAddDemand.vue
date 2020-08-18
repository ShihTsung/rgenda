<template>
  <!-- modal - add demand -->
  <div class="modal fade" id="modalAddShift" tabindex="-1" role="dialog" aria-hidden="true"
  data-backdrop="static">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header border-bottom-0">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"
          @click="cancelAddition()">
            <span aria-hidden="true">
              <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path d="M24 20.188l-8.315-8.209 8.2-8.282-3.697-3.697-8.212 8.318-8.31-8.203-3.666 3.666 8.321 8.24-8.206 8.313 3.666 3.666 8.237-8.318 8.285 8.203z"/></svg>
            </span>
          </button>
        </div>
        <div class="modal-body text-center pt-0">
          <h3 class="modal-title rgenda-text-dark-blue mb-4">新增人力配置</h3>
          <div class="mb-4">
            <div class="form-group row">
              <label for="selectStation" class="offset-md-1 col-sm-3 col-form-label">工作站</label>
              <div class="col-sm-7">
                <select id="selectStation" class="form-control"
                v-model="addShift.stationId">
                  <option :value="station.id"
                  v-for="(station, idx) in stations"
                  :key="['station', idx, station.id].join('_')">{{ station.name }}</option>
                </select>
              </div>
            </div>
            <div class="form-group row">
              <label for="selectShift" class="offset-md-1 col-sm-3 col-form-label">班別</label>
              <div class="col-sm-7">
                <select id="selectShift" class="form-control"
                v-model="addShift.shiftId">
                  <option :value="shift.id"
                  v-for="(shift, idx) in shifts"
                  :key="['shift', idx, shift.id].join('_')">{{ shift.name }}</option>
                </select>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col mb-2">
              <button class="btn btn-rgenda" type="button"
              @click="cancelAddition()"
              data-dismiss="modal">取消</button>
              <button id="btn-delete" class="btn btn-rgenda"
              @click="store()"
              type="button">新增</button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- \modal - add demand -->
</template>

<script>
import popup from 'common/popup';
import {
  httpRep
} from 'common/helpers';

export default {
  props: {
    csrfToken: {
      type: String,
      default: '',
    },
  },
  data() {
    return {
      stations: [],
      shifts: [],
      levels: [],
      addShift: {
        stationId: 0,
        shiftId: 0,
        level: 0,
      },
    };
  },
  methods: {
    getStations() {
      let self = this;
      let url = `/api/stations/`;
      this.$httpClient.get(url)
        .then(function (response) {
          let data = response.data;
          if (data.length > 0) {
            self.stations = data;
          } else {
            self.stations = [];
          }
        })
        .catch(function (error) {
          // handle error
          popup.error({
            title: error.title,
            html: httpRep.messageJoin(error.message),
          });
          console.log(error);
        });
    },
    getShifts() {
      let self = this;
      let url = `/api/shifts/`;
      this.$httpClient.get(url)
        .then(function (response) {
          let data = response.data;
          if (data.length > 0) {
            let filterTypes = [0, 1, 2, 4];
            self.shifts = data.filter(function(item) {
              return filterTypes.includes(item.shift_type);
            });
          } else {
            self.shifts = [];
          }
        })
        .catch(function (error) {
          // handle error
          popup.error({
            title: error.title,
            html: httpRep.messageJoin(error.message),
          });
          console.log(error);
        });
    },
    store() {
      let self = this;
      $('#modalAddShift').modal('hide');

      if (self.addShift.stationId < 1 || self.addShift.shiftId < 1) {
        return;
      }

      popup.loading({
        title: '處理中...',
      });

      let url = `/api/demands/`;
      const formConfig = {
        headers: {
          'X-CSRFToken': `${self.csrfToken}`
        }
      };

      let promiseArr = self.levels.map(function(id) {
        let params = {
          station: self.addShift.stationId,
          shift: self.addShift.shiftId,
          level: id,
          config1: 0,
          config2: 0,
        };
        self.$httpClient.post(url, params, formConfig)
          .then(function (response) {
            // debug
            // console.log(`add params =`);
            // console.log(params);
          })
          .catch(function (error) {
            // handle error
            popup.error({
              title: error.title,
              html: httpRep.messageJoin(error.message),
            });
            console.log(error);
          });
      });

      Promise.all(
        promiseArr
      ).then(function (response) {
        popup.success({
          title: '新增人力配置',
          text: '請求成功',
        }, function() {
          location.reload();
        });
      }).catch(function (error) {
        // handle error
        popup.error({
          title: error.title,
          html: httpRep.messageJoin(error.message),
        });
        console.log(error);
      });;
    },
    cancelAddition() {
      this.addShift = {
        stationId: 0,
        shiftId: 0,
        level: 0,
      };
    },
  },
  mounted() {
    this.getStations();
    this.getShifts();
    this.levels = [
      this.$getUserLevelValue('VALUE_NORMAL'),
      this.$getUserLevelValue('VALUE_SENIOR'),
    ];
  }
}
</script>
