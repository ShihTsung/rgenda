<template>
  <div>
    <div class="row mb-2">
      <div class="col-12">
        <div class="float-right">
          <!-- 新增工作站 -->
          <a v-if="filteredDepartments.length > 0"
          href="#" class="btn icon-bts m-0" data-tooltip="tooltip" title="新增工作站" data-toggle="modal" data-target="#modalAddStation">
            <svg xmlns="http://www.w3.org/2000/svg" class="icon-color" width="24" height="24" viewBox="0 0 24 24">
              <path d="M24 10h-10v-10h-4v10h-10v4h10v10h4v-10h10z"/></svg>
          </a>
          <!-- \新增工作站 -->
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
          <div class="icon-bts btn-sm" data-tooltip="tooltip" title="編輯"
          @click="confirmEdit(props.row)"><i class="fas fa-edit"></i></div>
          <div class="icon-bts btn-sm" data-tooltip="tooltip" title="刪除" data-toggle="modal" data-target="#modalDeleteStation"
          @click="confirmDelete(props.row)"><i class="fa fa-trash-alt"></i></div>
        </template>
      </template>
    </vue-good-table>
    <div v-if="noData">
      <div class="row col-12 text-center">
        <p class="form-control-plaintext">無資料</p>
      </div>
    </div>
    <!-- \users table -->

    <modal-add-station
    :csrf-token="csrfToken"
    :department-list="filteredDepartments"
    :my-department-id="myDepartmentId"></modal-add-station>

    <modal-delete-station
    :csrf-token="csrfToken"
    :delete-station="deleteStation"></modal-delete-station>

    <modal-edit-station
    :csrf-token="csrfToken"
    :department-list="filteredDepartments"
    :station-data="editStation"></modal-edit-station>

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
import ModalAddStation from './ModalAddStation.vue';
import ModalDeleteStation from './ModalDeleteStation.vue';
import ModalEditStation from './ModalEditStation.vue';

export default {
  components: {
    VueGoodTable,
    ModalAddStation,
    ModalDeleteStation,
    ModalEditStation,
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
      editStation: {},
      deleteStation: {
        id: 0,
        name: '',
      },
      columns: [{
          label: '編號',
          field: 'id',
          type: 'number',
        },
        {
          label: '工作站名稱',
          field: 'name',
        },
        {
          label: '所屬科別',
          field: 'department',
        },
        {
          label: '功能',
          field: 'actions',
          sortable: false,
        },
      ],
      rows: [],
      filters: ['休假', '公假'],
      filteredDepartments: [],
    };
  },
  methods: {
    getStations() {
      let self = this;
      let url = `/api/stations/?department=${this.myDepartmentId}`;
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
        return !self.filters.includes(obj.name);
      }).map(function (obj) {
        return {
          id: obj.id,
          department: obj.department.name,
          departmentId: obj.department.id,
          name: obj.name,
        };
      });
    },
    getDepartments() {
      let self = this;
      let url = `/api/departments/?department=${this.myDepartmentId}`;
      self.$httpClient.get(url)
        .then(function (response) {
          let data = response.data;
          if (data.length > 0) {
            self.filteredDepartments = data.filter(function (obj) {
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
    confirmDelete(row) {
      this.deleteStation = {
        id: row.id,
        name: row.name,
      };
    },
    cancelDelete() {
      this.deleteStation = {
        id: 0,
        name: '',
      };
    },
    confirmEdit(row) {
      this.editStation = {
        id: row.id,
        departmentId: row.departmentId,
        name: row.name,
      };

      $('#modalEditStation').modal('show');
    },
    cancelEdit() {
      this.editStation = {};
    },
  },
  mounted() {
    this.getStations();
    this.getDepartments();
  },
}
</script>
