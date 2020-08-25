<template>
  <div>
    <div class="row mb-2">
      <div class="col-12">
        <div class="float-right">
          <!-- 新增人力配置 -->
          <a v-if="filteredDepartments.length > 0"
          href="#" class="btn icon-bts m-0" data-tooltip="tooltip" title="新增班別" data-toggle="modal" data-target="#modalAddShift">
            <svg xmlns="http://www.w3.org/2000/svg" class="icon-color" width="24" height="24" viewBox="0 0 24 24">
              <path d="M24 10h-10v-10h-4v10h-10v4h10v10h4v-10h10z"/></svg>
          </a>
          <!-- \新增人力配置 -->
        </div>
      </div>
    </div>
    <!-- users table -->
    <vue-good-table v-if="loaded"
      :columns="columns"
      :rows="rows"
      :search-options="{
        enabled: true,
      }">
      <template slot="table-row" slot-scope="props">
        <template v-if="props.column.field == 'actions'">
          <a class="icon-bts btn-sm" data-tooltip="tooltip" title="編輯"
          :href="'/shifts/update/' + props.row.id"><i class="fas fa-edit"></i></a>
          <div class="icon-bts btn-sm" data-tooltip="tooltip" title="刪除" data-toggle="modal" data-target="#modalDeleteShift"
          @click="comfirmDelete(props.row)"><i class="fa fa-trash-alt"></i></div>
        </template>
      </template>
    </vue-good-table>
    <div v-if="noData">
      <div class="row col-12 text-center">
        <p class="form-control-plaintext">無資料</p>
      </div>
    </div>
    <!-- \users table -->

    <modal-add-shift
    :csrf-token="csrfToken"
    :department-list="filteredDepartments"
    :my-department-id="myDepartmentId"></modal-add-shift>

    <modal-delete-shift
    :csrf-token="csrfToken"
    :delete-shift="deleteShift"></modal-delete-shift>
  </div>
</template>

<script>
import popup from 'common/popup';
import {
  httpRep
} from 'common/helpers';
import 'vue-good-table/dist/vue-good-table.css'
import {
  VueGoodTable
} from 'vue-good-table';
import ModalAddShift from './ModalAddShift.vue';
import ModalDeleteShift from './ModalDeleteShift.vue';

export default {
  components: {
    VueGoodTable,
    ModalAddShift,
    ModalDeleteShift,
  },
  props: {
    myDepartmentId: {
      type: Number,
      default: 0,
    },
    csrfToken: {
      type: String,
      default: '',
    },
  },
  data() {
    return {
      loaded: false,
      noData: false,
      deleteShift: {
        id: 0,
        name: '',
      },
      columns: [{
          label: '編號',
          field: 'id',
          type: 'number',
        },
        {
          label: '科別',
          field: 'department',
        },
        {
          label: '班別名稱',
          field: 'name',
        },
        {
          label: '類型',
          field: 'shiftType',
        },
        {
          label: '開始時間',
          field: 'startTime',
        },
        {
          label: '結束時間',
          field: 'endTime',
        },
        {
          label: '工時長度',
          field: 'workHours',
          type: 'number',
        },
        {
          label: '功能',
          field: 'actions',
          sortable: false,
        },
      ],
      rows: [],
      filters: [],
      filteredDepartments: [],
    };
  },
  methods: {
    getShifts() {
      let self = this;
      let url = `/api/shifts/`;
      self.$httpClient.get(url)
        .then(function (response) {
          let data = response.data;
          if (data.length > 0) {
            self.rows = self.transformer(data);
            self.loaded = true;
            self.noData = false;
          } else {
            self.rows = [];
            self.noData = true;
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
      return data.filter(function (obj) {
        // 0 白班，1 小夜，2 大夜，4 oncall
        return self.filters.includes(obj.shift_type);
      }).map(function (obj) {
        return {
          id: obj.id,
          department: obj.department.detail,
          name: obj.name,
          shiftType: self.$getShiftTypeText(obj.shift_type),
          startTime: obj.start_time,
          endTime: obj.end_time,
          workHours: obj.work_hours,
        };
      });
    },
    getDepartments() {
      let self = this;
      let url = `/api/departments/`;
      self.$httpClient.get(url)
        .then(function (response) {
          let data = response.data;
          if (data.length > 0) {
            self.filteredDepartments = data.filter(function(obj) {
              return obj.id == self.myDepartmentId;
            });
          } else {
            self.filteredDepartments = [];
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
    comfirmDelete(row) {
      this.deleteShift = {
        id: row.id,
        name: row.name,
      };
    },
    cancelDelete() {
      this.deleteShift = {
        id: 0,
        name: '',
      };
    },
  },
  mounted() {
    this.getShifts();
    this.getDepartments();
    this.filters = [
      this.$getShiftTypeValue('VALUE_DAY_SHIFT'),
      this.$getShiftTypeValue('VALUE_NIGHT_SHIFT'),
      this.$getShiftTypeValue('VALUE_GRAVEYARD_SHIFT'),
      this.$getShiftTypeValue('VALUE_ON_CALL')
    ];
  },
}
</script>
