<template>
<div>
  <div class="row mb-2">
    <div class="col-12">
      <div class="float-right">
        <!-- 出缺勤補登 -->
        <div class="btn icon-bts m-0" data-tooltip="tooltip" title="出缺勤補登" data-toggle="modal" data-target="#modalAddTimeAdjustment">
          <svg xmlns="http://www.w3.org/2000/svg" class="icon-color" width="24" height="24" viewBox="0 0 24 24">
            <path d="M24 10h-10v-10h-4v10h-10v4h10v10h4v-10h10z"/></svg>
        </div>
        <!-- \出缺勤補登 -->
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
            <button type="button" class="btn btn-rgenda" @click="query()">查詢</button>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="mt-5">
    <hr class="">
    <!-- users table -->
    <vue-good-table v-if="loaded"
      :columns="columns"
      :rows="rows">
      <template slot="table-row" slot-scope="props">
        <template v-if="props.column.field == 'canBeScheduled'">
          <div class="form-check">
            <input class="form-check-input" type="checkbox" value="" :id="'canBeScheduled_' + props.row.id"
            @change="changeSchedule(props.row.id, props.row.username, !props.row.canBeScheduled)"
            :checked="props.row.canBeScheduled">
            <label class="form-check-label" :for="'canBeScheduled_' + props.row.id">
              正常排班
            </label>
        </div>
        </template>
        <template v-else-if="props.column.field == 'actions'">
          <a class="icon-bts btn-sm" data-tooltip="tooltip" title="編輯"
          :href="'/accounts/' + props.row.id"><i class="fas fa-edit"></i></a>
          <div class="icon-bts btn-sm" data-tooltip="tooltip" title="刪除" data-toggle="modal" data-target="#modalDelete"
          @click="comfirmDeletion(props.row)"><i class="fa fa-trash-alt"></i></div>
        </template>
      </template>
    </vue-good-table>
    <!-- \users table -->
  </div>

  <modal-add-time-adjustment v-if="suggestions.length > 0"
    :suggestions="suggestions"
    :csrf-token="csrfToken"></modal-add-time-adjustment>
</div>
</template>

<script>
import popup from 'common/popup';
import {
  httpRep
} from 'common/helpers';
import 'vue-good-table/dist/vue-good-table.css'
import { VueGoodTable } from 'vue-good-table';
import moment from 'moment';
import DatePicker from 'v-calendar/lib/components/date-picker.umd';
import Autocomplete from 'components/partial/Autocomplete.vue';
import ModalAddTimeAdjustment from './ModalAddTimeAdjustment.vue';

export default {
  components: {
    VueGoodTable,
    DatePicker,
    Autocomplete,
    ModalAddTimeAdjustment,
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
          type: 'date',
        },
        {
          label: '項目',
          field: 'adjustmentItem',
          sortable: false,
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
          sortable: false,
        },
        {
          label: '刪除',
          field: 'actions',
          sortable: false,
        },
      ],
      rows: [],
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
    $_timeAdjustment_query_validate() {
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
    query() {
      let self = this;
      let [bool, errMsg] = this.$_timeAdjustment_query_validate();
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
      if (Number.isInteger(self.selectedType)) {
        params.type = self.selectedType;
      }
      if (Number.isInteger(self.selectedItem)) {
        params.item = self.selectedItem;
      }
      let queryString = Object.keys(params).map((key) => {
        return encodeURIComponent(key) + '=' + encodeURIComponent(params[key])
      }).join('&');

      let url = `/api/time-adjustment/?${queryString}`;
      self.$httpClient.get(url)
        .then(function (response) {
          let data = response.data;
          if (data.length > 0) {
            console.log(data);
            // self.suggestions = self.transformer(data);
            self.loaded = true;
          } else {
            self.rows = [];
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
    comfirmDeletion(row) {
      this.deleteUser = {
        id: row.id,
        fullName: row.fullName,
      };
    },
    destory() {
      let self = this;

      $('#modalDelete').modal('hide');

      popup.loading({
        title: '處理中...',
      });

      let url = `/api/users/${self.deleteUser.id}/`;
      const formConfig = {
        headers: {
          'X-CSRFToken': `${this.csrfToken}`
        }
      }
      self.$httpClient.delete(url, formConfig)
        .then(function (response) {
          self.rows = self.rows.filter(function(obj) {
            return obj.id !== self.deleteUser.id;
          });

          popup.success({
            title: '刪除人員',
            text: '請求成功',
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
    cancelDeletion() {
      this.deleteUser = {
        id: 0,
        fullName: '',
      };
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
        console.log(374, this.selectedType, value)
        if (oldValue !== value) {
          this.selectedItem = this.selectedType == this.$getTimeAdjustmentTypeValue('TYPE_INCREASE_HOURS') ? this.$getTimeAdjustmentItemValue('ITEM_WORK_OVERTIME') : this.$getTimeAdjustmentItemValue('ITEM_INSTITUTION_REDUCE_CLASS');
          console.log(376, this.selectedItem)
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
  },
}
</script>
