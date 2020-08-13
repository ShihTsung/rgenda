<template>
  <div>
    <!-- modal - delete department -->
    <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header border-bottom-0">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path d="M24 20.188l-8.315-8.209 8.2-8.282-3.697-3.697-8.212 8.318-8.31-8.203-3.666 3.666 8.321 8.24-8.206 8.313 3.666 3.666 8.237-8.318 8.285 8.203z"/></svg>
              </span>
            </button>
          </div>
          <div class="modal-body text-center pt-0">
            <h3 class="modal-title mb-4">刪除科別</h3>
            <p class="mb-4">是否確認刪除？</p>
            <div class="row">
              <div class="col mb-2">
                <button class="btn btn-rgenda" type="button" data-dismiss="modal">取消</button>
                <button id="btn-delete" class="btn btn-rgenda" type="button" @click="deleteRow()" data-dismiss="modal">刪除</button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- \modal - delete department -->
    <!-- modal - show department info -->
    <department-modal :rowData="rowData"></department-modal>
    <!-- \modal - show department info -->
    <!-- department table -->
    <vue-good-table
      :columns="columns"
      :rows="rows"
      :search-options="{ enabled: true }"
      :saveDeleteRowId="saveDeleteRowId">
      <template slot="table-row" slot-scope="props">
        <span v-if="props.column.field === 'actions'">
          <div class="icon-bts icon-color" @click="showRowData(props.row.id)" data-tooltip="tooltip" data-toggle="modal" data-target="#infoModal" title="科別內容">
            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24"><path d="M13 8h-8v-1h8v1zm0 2h-8v-1h8v1zm-3 2h-5v-1h5v1zm11.172 12l-7.387-7.387c-1.388.874-3.024 1.387-4.785 1.387-4.971 0-9-4.029-9-9s4.029-9 9-9 9 4.029 9 9c0 1.761-.514 3.398-1.387 4.785l7.387 7.387-2.828 2.828zm-12.172-8c3.859 0 7-3.14 7-7s-3.141-7-7-7-7 3.14-7 7 3.141 7 7 7z"/></svg>
          </div>
          <a class="icon-bts" :href="'/departments/update/'+props.row.id" data-tooltip="tooltip" title="編輯">
            <i class="fa fa-edit"></i>
          </a>
          <div class="icon-bts" @click="saveDeleteRowId(props.row.id)" data-tooltip="tooltip" data-toggle="modal" data-target="#deleteModal" title="刪除">
            <i class="fa fa-eraser"></i>
          </div>
        </span>
        <span v-else>
          {{props.formattedRow[props.column.field]}}
        </span>
      </template>
    </vue-good-table>
    <!-- \department table -->
  </div>
</template>
<script>
import DepartmentModal from './DepartmentModal';
export default {
  data(){
    return {
      departmentList: [],
      users: [],
      columns: [
        {
          label: '編號',
          field: 'id',
          type: 'number',
          width: '70px',
        },
        {
          label: '簡稱',
          field: 'name',
          width: '70px',
        },
        {
          label: '科別名稱',
          field: 'detail',
          width: '140px',
        },
        {
          label: '管理人',
          field: 'users',
        },
        {
          label: '',
          field: 'actions',
          width: '200px',
          sortable: false,
        }
      ],
      deleteRowId: -1,
      rowData: {},
    };
  },
  methods: {
    deleteRow() {
      console.log('deleteRow ' + this.deleteRowId);
      let self = this;
      const formConfig = {
        headers: {
          'X-CSRFToken': `${this.csrfToken}`
        }
      };
      this.$httpClient.delete('/api/departments/'+this.deleteRowId, formConfig).then(response => {
        let idx = self.departmentList.find(department => department.id === self.deleteRowId);
        self.departmentList.splice(idx, 1);
        self.deleteRowId = -1;
      }).catch((err) => {
        console.log(err)
      });
    },
    getDepartmentList() {
      let self = this;
      this.$httpClient.get('/api/departments/').then(response => {
        self.departmentList = response.data;
      }).catch((err) => {
        console.log(err);
      });
    },
    getUsers() {
      let self = this;
      this.$httpClient.get('/api/users/').then(response => {
        self.users = response.data;
      }).catch((err) => {
        console.log(err);
      });
    },
    saveDeleteRowId(rowId) {
      this.deleteRowId = rowId;
    },
    showRowData(rowId) {
      this.rowData = this.rows.find(row => row.id == rowId);
    },
  },
  computed: {
    rows() {
      return this.departmentList.map(department => {
        let departmentUsers = this.users.filter(user => user.department.id === department.id)
          .map(user => user.full_name)
          .join('、');
        let newDepartment = Object.assign({}, department, {
          users: departmentUsers,
          actions: '',
        });
        return newDepartment;
      });
    },
  },
  mounted() {
    this.getDepartmentList();
    this.getUsers();
  },
  props: ['role', 'csrf-token'],
  components: {
    DepartmentModal,
  },
}
</script>
