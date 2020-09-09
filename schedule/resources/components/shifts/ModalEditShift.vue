<template>
  <!-- modal - edit shift -->
  <div class="modal fade" id="modalEditShift" tabindex="-1" role="dialog" aria-hidden="true"
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
          <h3 class="modal-title rgenda-text-dark-blue mb-4">編輯班別</h3>
          <div class="container-fluid text-left">
            <div class="form-group">
              <label class="font-weight-bold">科別</label>
              <div class="form-group">
                <div class="form-check form-check-inline"
                v-for="(item, idx) in departmentList"
                :key="['item', idx, item.id].join('_')">
                  <input class="form-check-input" type="radio"
                  v-model="editShift.departmentId"
                  :id="['edit_rdo_department', idx, item.id].join('_')"
                  :value="item.id">
                  <label class="form-check-label" :for="['edit_rdo_department', idx, item.id].join('_')">{{ item.name }}</label>
                </div>
              </div>
            </div>
            <div class="form-group">
              <label class="font-weight-bold">班別名稱</label>
              <input type="text" class="form-control" v-model="editShift.name">
            </div>
            <div class="form-group">
              <label class="font-weight-bold">班別代號</label>
              <input type="text" class="form-control" v-model="editShift.code">
            </div>
            <div class="form-group">
              <label class="font-weight-bold">類型</label>
              <div class="form-group">
                <div class="form-check form-check-inline"
                v-for="(item, idx) in $getWorkShiftTypeList()"
                :key="['type', idx, item.id].join('_')">
                  <input class="form-check-input" type="radio"
                  v-model="editShift.shiftTypeId"
                  :id="['edit_rdo_type', idx, item.id].join('_')"
                  :value="item.id">
                  <label class="form-check-label" :for="['edit_rdo_type', idx, item.id].join('_')">{{ item.text }}</label>
                </div>
              </div>
            </div>
            <div class="form-group">
              <label class="font-weight-bold">開始時間</label>
              <div class="form-group">
                <vue-timepicker
                close-on-complete
                v-model="editShift.startTime"></vue-timepicker>
              </div>
            </div>
            <div class="form-group">
              <label class="font-weight-bold">結束時間</label>
              <div class="form-group">
                <vue-timepicker
                close-on-complete
                v-model="editShift.endTime"></vue-timepicker>
              </div>
            </div>
            <div class="form-group">
              <label class="font-weight-bold">工時長度</label>
              <input type="number" class="form-control" v-model="editShift.workHours">
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
  <!-- \modal - edit shift -->
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
      default: function() {
        return [];
      },
    },
    shiftData: {
      type: Object,
      default: function() {
        return {};
      },
    },
  },
  data() {
    return {
      editShift: {
        departmentId: 0,
        name: '',
        code: '',
        shiftTypeId: 0,
        startTime: '',
        endTime: '',
        workHours: 0,
      },
    };
  },
  methods: {
    $_shifts_update_validate() {
      let errMsg = [];
      let valid = true;
      if (1 > this.editShift.name.length) {
        valid = false;
        errMsg.push('班別名稱欄位未填寫');
      }
      if (1 > this.editShift.code.length) {
        valid = false;
        errMsg.push('班別代號欄位未填寫');
      }
      if (1 > this.editShift.startTime.length) {
        valid = false;
        errMsg.push('開始時間欄位格式錯誤');
      }
      if (1 > this.editShift.endTime.length) {
        valid = false;
        errMsg.push('結束時間欄位格式錯誤');
      }
      this.editShift.workHours = parseInt(this.editShift.workHours);
      if (0 > this.editShift.workHours) {
        valid = false;
        errMsg.push('工時長度不能小於 0');
      } else if (10 < this.editShift.workHours) {
        valid = false;
        errMsg.push('工時長度不能大於 10');
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

      $('#modalEditShift').modal('hide');

      popup.loading({
        title: '處理中...',
      });

      let url = `/api/shifts/${self.editShift.id}/`;
      const formConfig = {
        headers: {
          'X-CSRFToken': `${self.csrfToken}`
        }
      };

      let params = {
        name: self.editShift.name,
        code: self.editShift.code,
        shift_type: self.editShift.shiftTypeId,
        start_time: self.editShift.startTime,
        end_time: self.editShift.endTime,
        department: self.editShift.departmentId,
        work_hours: Number(self.editShift.workHours),
      };
      self.$httpClient.put(url, params, formConfig)
        .then(function () {
          popup.success({
            title: '編輯班別',
            text: '請求成功',
          }, function () {
            self.cancelEdit();
            self.$parent.getShifts();
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
    shiftData: function () {
      Object.assign(this.editShift, this.shiftData);
    },
  },
}
</script>
