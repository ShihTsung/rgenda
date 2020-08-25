<template>
  <!-- modal - add time adjustment -->
  <div class="modal fade" id="modalAddTimeAdjustment" tabindex="-1" role="dialog" aria-hidden="true"
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
          <h3 class="modal-title rgenda-text-dark-blue mb-4">出缺勤補登</h3>
          <div class="container-fluid text-left">
            <div class="form-group">
              <label class="font-weight-bold">類別</label>
              <div class="form-group">
                <div class="form-check form-check-inline"
                v-for="(item, idx) in $getAllTimeAdjustmentTypeText()"
                :key="['type', idx, item.id].join('_')">
                  <input class="form-check-input" type="radio"
                  v-model="selectedType"
                  :id="['add_rdo_type', idx, item.id].join('_')"
                  :value="item.id">
                  <label class="form-check-label" :for="['add_rdo_type', idx, item.id].join('_')">{{ item.text }}</label>
                </div>
              </div>
            </div>
            <div class="form-group" v-if="isSelectSingleType">
              <label class="font-weight-bold">項目</label>
              <div class="form-group">
                <div class="form-check form-check-inline"
                v-for="(item, idx) in itemList"
                :key="['item', idx, item.id].join('_')">
                  <input class="form-check-input" type="radio"
                  v-model="selectedItem"
                  :id="['add_rdo_item', idx, item.id].join('_')"
                  :value="item.id">
                  <label class="form-check-label" :for="['add_rdo_item', idx, item.id].join('_')">{{ item.text }}</label>
                </div>
              </div>
            </div>
            <div class="form-group">
              <label class="font-weight-bold">日期</label>
                <date-picker
                v-model="addTimeAdjustment.startDate"
                :masks="{L: 'YYYY-MM-DD'}"
                :is-required="true"
                :popover="{visibility: 'focus'}"
                :input-props='{
                  placeholder: "開始日期"
                }'
                ></date-picker>
            </div>
            <div class="form-group">
              <label class="font-weight-bold">時數</label>
              <input type="number" class="form-control" v-model="addTimeAdjustment.hours">
              <small class="form-text text-danger" v-if="isOverHours">
                超過法定上限 12 小時
              </small>
            </div>
            <div class="form-group">
              <label class="font-weight-bold">姓名</label>
              <autocomplete class="p-0" v-if="suggestions.length > 0"
              :suggestions="suggestions"
              :placeholder="'輸入姓名以選取人員'"
              v-model="addTimeAdjustment.selection"></autocomplete>
            </div>
            <div class="form-group">
              <label class="font-weight-bold">備註</label>
              <textarea class="form-control" row="3" v-model="addTimeAdjustment.remark"
              placeholder="不得超過 100 字"></textarea>
            </div>
            <div class="row">
              <div class="col mb-2 text-center">
                <button class="btn btn-rgenda" type="button"
                @click="cancelAddition()"
                data-dismiss="modal">取消</button>
                <button id="btn-delete" class="btn btn-rgenda"
                @click="store()"
                type="button">儲存</button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- \modal - add time adjustment -->
</template>

<script>
import popup from 'common/popup';
import {
  httpRep
} from 'common/helpers';
import moment from 'moment';
import DatePicker from 'v-calendar/lib/components/date-picker.umd';
import Autocomplete from 'components/partial/Autocomplete.vue';

export default {
  components: {
    DatePicker,
    Autocomplete,
  },
  props: {
    csrfToken: {
      type: String,
      default: '',
    },
    suggestions: {
      type: Array,
      default: [],
    }
  },
  data() {
    return {
      stations: [],
      shifts: [],
      levels: [],
      selectedType: 0,
      selectedItem: 0,
      addTimeAdjustment: {
        startDate: moment().toDate(), // Must be Date Object
        hours: 0,
        selection: {
          id: 0,
          text: '',
        },
        remark: '',
      },
    };
  },
  methods: {
    $_timeAdjustment_store_validate() {
      let errMsg = [];
      let valid = true;
      if (null === this.addTimeAdjustment.startDate) {
        valid = false;
        errMsg.push('日期欄位格式錯誤');
      }
      if (0 >= Number(this.addTimeAdjustment.hours)) {
        valid = false;
        errMsg.push('時數欄位值不能小於 0 ');
      }
      if (12 < Number(this.addTimeAdjustment.hours)) {
        valid = false;
        errMsg.push('時數欄位值超過法定上限 12 小時');
      }
      if (1 > this.addTimeAdjustment.selection.id) {
        valid = false;
        errMsg.push('姓名欄位未填寫');
      }
      if (100 < this.addTimeAdjustment.remark.length) {
        valid = false;
        errMsg.push('備註不得超過 100 字');
      }

      return [valid, errMsg];
    },
    store() {
      let self = this;
      let [bool, errMsg] = this.$_timeAdjustment_store_validate();
      if (!bool) {
        popup.error({
          title: '驗證錯誤',
          html: httpRep.messageJoin(errMsg),
        });
        return false;
      }

      $('#modalAddTimeAdjustment').modal('hide');

      popup.loading({
        title: '處理中...',
      });

      let url = `/api/time-adjustment/`;
      const formConfig = {
        headers: {
          'X-CSRFToken': `${self.csrfToken}`
        }
      };

      let params = {
        user: self.addTimeAdjustment.selection.id,
        date: moment(self.addTimeAdjustment.startDate).format('YYYY-MM-DD'),
        hours: self.addTimeAdjustment.hours,
        adjustment_type: self.selectedType,
        adjustment_item: self.selectedItem,
        remark: self.addTimeAdjustment.remark,
      };
      self.$httpClient.post(url, params, formConfig)
        .then(function (response) {
          popup.success({
            title: '出缺勤補登',
            text: '請求成功',
          }, function () {
            self.cancelAddition();
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
    cancelAddition() {
      Object.assign(this.$data, this.$options.data.apply(this));
    },
  },
  mounted() {
  },
  watch: {
    selectedType: function(value, oldValue) {
      if ('all' === value) {
        this.selectedItem = 'all';
      } else {
        if (oldValue !== value) {
          this.selectedItem = this.selectedType == this.$getTimeAdjustmentTypeValue('TYPE_INCREASE_HOURS') ? this.$getTimeAdjustmentItemValue('ITEM_WORK_OVERTIME') : this.$getTimeAdjustmentItemValue('ITEM_INSTITUTION_REDUCE_CLASS');
        }
      }
    },
  },
  computed: {
    isSelectSingleType() {
      return this.selectedType !== 'all';
    },
    itemList() {
      return this.$getTimeAdjustmentItemsByTypeKey(Number(this.selectedType));
    },
    isOverHours() {
      return 12 < Number(this.addTimeAdjustment.hours);
    },
  },
}
</script>
