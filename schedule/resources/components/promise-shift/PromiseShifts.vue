<template>
<div>
  <div class="row mb-2">
    <div class="col-12">
      <div class="float-right">
        <!-- 新增假勤 -->
        <div class="btn icon-bts m-0" data-tooltip="tooltip" title="新增假勤" data-toggle="modal" data-target="#modalAddPromiseShift">
          <svg xmlns="http://www.w3.org/2000/svg" class="icon-color" width="24" height="24" viewBox="0 0 24 24">
            <path d="M24 10h-10v-10h-4v10h-10v4h10v10h4v-10h10z"/></svg>
        </div>
        <!-- \新增假勤 -->
      </div>
    </div>
  </div>
  <div class="container-fluid">
    <div class="row">
      <div class="col-12 p-0">
        <div class="card">
          <div class="card-header bg-white">
            <div class="card-title mb-0">
              <h4 class="rgenda-text-dark-blue mb-0">記錄查詢</h4>
            </div>
          </div>
          <div class="card-body">
            <div class="form-group">
              <label class="font-weight-bold">時間</label>
              <div class="row">
                <div class="col-4">
                  <date-picker
                  v-model="startDate"
                  :masks="{L: 'YYYY-MM-DD'}"
                  :is-required="true"
                  :popover="{visibility: 'focus'}"
                  :input-props='{
                    placeholder: "開始日期"
                  }'
                  ></date-picker>
                </div>
                <span> - </span>
                <div class="col-4">
                  <date-picker
                  v-model="endDate"
                  :masks="{L: 'YYYY-MM-DD'}"
                  :is-required="true"
                  :popover="{visibility: 'focus'}"
                  :input-props='{
                    placeholder: "結束日期"
                  }'
                  ></date-picker>
                </div>
              </div>
            </div>
            <div class="form-group">
              <label class="font-weight-bold">類別</label>
              <div class="form-group">
                <div class="form-check form-check-inline">
                  <input class="form-check-input" type="radio"
                  id="rdo_type_all" value="all"
                  v-model="selectedType">
                  <label class="form-check-label" for="rdo_type_all">全選</label>
                </div>
                <div class="form-check form-check-inline"
                v-for="(item, idx) in $getAllTimeAdjustmentTypeText()"
                :key="['type', idx, item.id].join('_')">
                  <input class="form-check-input" type="radio"
                  v-model="selectedType"
                  :id="['rdo_type', idx, item.id].join('_')"
                  :value="item.id">
                  <label class="form-check-label" :for="['rdo_type', idx, item.id].join('_')">{{ item.text }}</label>
                </div>
              </div>
            </div>
            <div class="form-group" v-if="isSelectSingleType">
              <label class="font-weight-bold">項目</label>
              <div class="form-group">
                <div class="form-check form-check-inline">
                  <input class="form-check-input" type="radio"
                  id="rdo_item_all" value="all"
                  v-model="selectedItem">
                  <label class="form-check-label" for="rdo_item_all">全選</label>
                </div>
                <div class="form-check form-check-inline"
                v-for="(item, idx) in itemList"
                :key="['item', idx, item.id].join('_')">
                  <input class="form-check-input" type="radio"
                  v-model="selectedItem"
                  :id="['rdo_item', idx, item.id].join('_')"
                  :value="item.id">
                  <label class="form-check-label" :for="['rdo_item', idx, item.id].join('_')">{{ item.text }}</label>
                </div>
              </div>
            </div>
            <div class="form-group">
              <label class="font-weight-bold">姓名</label>
              <autocomplete class="col-6 p-0" v-if="suggestions.length > 0"
              :suggestions="suggestions"
              :placeholder="'輸入姓名以選取人員'"
              v-model="selection"></autocomplete>
            </div>
          </div>
          <div class="card-footer">
            <button type="button" class="btn btn-rgenda" @click="query(true)">查詢</button>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="mt-5" v-if="loaded">
    <hr class="">
    <div class="row mb-2">
      <div class="col-12">
        <div class="float-right h-2p2">
          &nbsp;
          <!-- 批次刪除出缺勤補登 -->
          <button type="button" class="btn btn-sm icon-bts m-0"
          @click="confirmDelete()"
          v-show="isReadyDelete">批次刪除</button>
          <!-- \批次刪除出缺勤補登 -->
        </div>
      </div>
    </div>
    <!-- users table -->
    <vue-good-table
      :columns="columns"
      :rows="rows">
      <template slot="table-row" slot-scope="props">
        <template v-if="props.column.field == 'actions'">
          <div class="form-check">
            <input class="form-check-input position-static" type="checkbox"
            :value="props.row.id"
            v-model="deleteItems">
          </div>
        </template>
      </template>
      <div slot="emptystate" class="text-center">
        無資料
      </div>
    </vue-good-table>
    <!-- \users table -->
  </div>

  <modal-add-promise-shift v-if="suggestions.length > 0"
    :suggestions="suggestions"
    :csrf-token="csrfToken"></modal-add-promise-shift>

  <modal-delete-promise-shift v-if="deleteItems.length > 0"
    :delete-items="deleteItems"
    :csrf-token="csrfToken"></modal-delete-promise-shift>
</div>
</template>

<script>
import popup from 'common/popup';
import {
  httpRep,
  nl2br,
} from 'common/helpers';
import 'vue-good-table/dist/vue-good-table.css'
import { VueGoodTable } from 'vue-good-table';
import moment from 'moment';
import DatePicker from 'v-calendar/lib/components/date-picker.umd';
import Autocomplete from 'components/partial/Autocomplete.vue';
import ModalAddPromiseShift from './ModalAddPromiseShift.vue';
import ModalDeletePromiseShift from './ModalDeletePromiseShift.vue';

export default {
  components: {
    VueGoodTable,
    DatePicker,
    Autocomplete,
    ModalAddPromiseShift,
    ModalDeletePromiseShift,
  },
  props: {
    csrfToken: {
      type: String,
      default: '',
    },
  },
  data() {
    return {
      loaded: false,
      startDate: moment().toDate(), // Must be Date Object
      endDate: moment().toDate(), // Must be Date Object,
      selectedType: 'all',
      selectedItem: 'all',
      selection: {
        id: 0,
        text: '',
      },
      suggestions: [],
      columns: [
        {
          label: '編號',
          field: 'id',
          type: 'number',
          sortable: false,
        },
        {
          label: '類別',
          field: 'adjustmentType',
          sortable: false,
        },
        {
          label: '日期',
          field: 'date',
        },
        {
          label: '時數',
          field: 'hours',
          type: 'number',
          sortable: false,
        },
        {
          label: '姓名',
          field: 'fullName',
          sortable: false,
        },
        {
          label: '備註',
          field: 'remark',
          html: true,
          sortable: false,
        },
        {
          label: '刪除',
          field: 'actions',
          sortable: false,
        },
      ],
      rows: [],
      deleteItems: [],
    };
  },
  methods: {
    isManager() {
      return ['admin', 'manager'].includes(this.role);
    },
    getUsers() {
      let self = this;
      let url = `/api/users/`;
      self.$httpClient.get(url)
        .then(function (response) {
          let data = response.data;
          if (data.length > 0) {
            self.suggestions = self.transformer(data);
          } else {
            self.suggestions = [];
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
    transformer(data) {
      let self = this;
      return data.map(function(obj) {
        return {
          id: obj.id,
          text: obj.full_name,
        };
      });
    },
    $_promiseShifts_query_validate() {
      let errMsg = [];
      let valid = true;
      if (null === this.startDate) {
        valid = false;
        errMsg.push('開始日期格式錯誤');
      }
      if (null === this.endDate) {
        valid = false;
        errMsg.push('結束日期格式錯誤');
      }
      if (1 > this.selection.id) {
        valid = false;
        errMsg.push('姓名欄位未填寫');
      }

      return [valid, errMsg];
    },
    query(showWarningPopup) {
      showWarningPopup = showWarningPopup || false;
      let self = this;
      self.deleteItems = [];

      let [bool, errMsg] = this.$_promiseShifts_query_validate();
      if (!bool) {
        popup.error({
          title: '驗證錯誤',
          html: httpRep.messageJoin(errMsg),
        });
        return false;
      }

      let params = {
        start: moment(self.startDate).format('YYYY-MM-DD'),
        end: moment(self.endDate).format('YYYY-MM-DD'),
        uid: self.selection.id,
      };
      if (0 <= Number(self.selectedType)) {
        params.type = self.selectedType;
      }
      if (0 <= Number(self.selectedItem)) {
        params.item = self.selectedItem;
      }
      let queryString = Object.keys(params).map((key) => {
        return encodeURIComponent(key) + '=' + encodeURIComponent(params[key])
      }).join('&');

      if (showWarningPopup) {
        popup.loading({
          title: '處理中...',
        });
      }

      let url = `/api/time-adjustment/?${queryString}`;
      self.$httpClient.get(url)
        .then(function (response) {
          let data = response.data;
          if (data.length > 0) {
            self.rows = self.$_timeAdjustment_query_result_transformer(data);
            self.loaded = true;
            if (showWarningPopup) {
              popup.success({
                title: '查詢出缺勤補登記錄',
                html: '請求成功',
              });
            }
          } else {
            self.rows = [];
            self.loaded = false;
            if (showWarningPopup) {
              popup.info({
                title: '查詢出缺勤補登記錄',
                html: '查無資料',
              });
            }
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
    $_promiseShifts_query_result_transformer(data) {
      let self = this;
      return data.map(function(obj) {
        return {
          id: obj.id,
          adjustmentType: self.$getTimeAdjustmentTypeText(obj.adjustment_type),
          date: obj.date,
          adjustmentItem: self.$getTimeAdjustmentItemText(obj.adjustment_type, obj.adjustment_item),
          hours: obj.hours,
          fullName: self.selection.text,
          remark: nl2br(obj.remark),
        };
      });
    },
    confirmDelete() {
      if (0 < this.deleteItems.length) {
        $('#modalDeletePromiseShift').modal('show');
      }
    },
    cancelDelete() {
      this.deleteItems = [];
    },
  },
  mounted() {
    this.getUsers();
  },
  watch: {
    selectedType: function(value, oldValue) {
      if ('all' === value) {
        this.selectedItem = 'all';
      } else {
        if (oldValue !== value) {
          this.selectedItem = 'all';
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
    isReadyDelete() {
      return 0 < this.deleteItems.length;
    },
  },
}
</script>

<style scoped>
.h-2p2 {
  height: 2.2rem;
}
</style>
