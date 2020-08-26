<template>
  <!-- modal - edit station -->
  <div class="modal fade" id="modalEditStation" tabindex="-1" role="dialog" aria-hidden="true"
  data-backdrop="static">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header border-bottom-0">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"
          @click="cancelEdit()">
            <span aria-hidden="true">
              <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path d="M24 20.188l-8.315-8.209 8.2-8.282-3.697-3.697-8.212 8.318-8.31-8.203-3.666 3.666 8.321 8.24-8.206 8.313 3.666 3.666 8.237-8.318 8.285 8.203z"/></svg>
            </span>
          </button>
        </div>
        <div class="modal-body text-center pt-0">
          <h3 class="modal-title rgenda-text-dark-blue mb-4">編輯工作站</h3>
          <div class="container-fluid text-left">
            <div class="form-group">
              <label class="font-weight-bold">工作站名</label>
              <input type="text" class="form-control" v-model="editStation.name">
            </div>
            <div class="form-group">
              <label class="font-weight-bold">所屬科別</label>
              <div class="form-group">
                <div class="form-check form-check-inline"
                v-for="(item, idx) in departmentList"
                :key="['item', idx, item.id].join('_')">
                  <input class="form-check-input" type="radio"
                  v-model="editStation.departmentId"
                  :id="['edit_rdo_department', idx, item.id].join('_')"
                  :value="item.id">
                  <label class="form-check-label" :for="['edit_rdo_department', idx, item.id].join('_')">{{ item.name }}</label>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col mb-2 text-center">
                <button class="btn btn-rgenda" type="button"
                @click="cancelEdit()"
                data-dismiss="modal">取消</button>
                <button id="btn-delete" class="btn btn-rgenda"
                @click="store()"
                type="button">更新</button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- \modal - edit station -->
</template>

<script>
import popup from 'common/popup';
import {
  httpRep
} from 'common/helpers';
import VueTimepicker from 'vue2-timepicker'
import 'vue2-timepicker/dist/VueTimepicker.css'

export default {
  components: {
    VueTimepicker,
  },
  props: {
    csrfToken: {
      type: String,
      default: '',
    },
    departmentList: {
      type: Array,
      default: [],
    },
    stationData: {
      type: Object,
      default: {},
    },
  },
  data() {
    return {
      editStation: {
        departmentId: 0,
        name: '',
      },
    };
  },
  methods: {
    $_shifts_update_validate() {
      let errMsg = [];
      let valid = true;
      if (1 > this.editStation.name.length) {
        valid = false;
        errMsg.push('工作站名欄位未填寫');
      }

      return [valid, errMsg];
    },
    store() {
      let self = this;
      let [bool, errMsg] = this.$_shifts_update_validate();
      if (!bool) {
        popup.error({
          title: '驗證錯誤',
          html: httpRep.messageJoin(errMsg),
        });
        return false;
      }

      $('#modalEditStation').modal('hide');

      popup.loading({
        title: '處理中...',
      });

      let url = `/api/stations/${self.editStation.id}/`;
      const formConfig = {
        headers: {
          'X-CSRFToken': `${self.csrfToken}`
        }
      };

      let params = {
        name: self.editStation.name,
        department: self.editStation.departmentId,
      };
      self.$httpClient.put(url, params, formConfig)
        .then(function (response) {
          popup.success({
            title: '編輯工作站',
            text: '請求成功',
          }, function () {
            self.cancelEdit();
            self.$parent.getStations();
          });
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
    cancelEdit() {
      Object.assign(this.$data, this.$options.data.apply(this));
    },
  },
  watch: {
    stationData: function () {
      Object.assign(this.editStation, this.stationData);
    },
  },
}
</script>
