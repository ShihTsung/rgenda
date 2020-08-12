<template>
  <div>
    <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h3 class="modal-title" id="exampleModalScrollableTitle">刪除科別</h3>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <p>是否確認刪除？</p>
            <div class="row">
              <div class="col text-right"><button class="btn btn-primary" type="button" data-dismiss="modal">取消</button></div>
              <div class="col text-left"><button id="btn-delete" class="btn btn-danger" type="button" @click="deleteRow()" data-dismiss="modal">刪除</button></div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <vue-good-table
      :columns="columns"
      :rows="rows"
      :search-options="{ enabled: true }"
      :row-style-class="rowStyleClassFn"
      :saveDeleteRowId="saveDeleteRowId">
      <template slot="table-row" slot-scope="props">
        <span v-if="props.column.field == 'actions'">
          <a class="icon-bts" :href="'/departments/update/'+props.formattedRow['id']" data-tooltip="tooltip" title="編輯">
            <i class="fa fa-edit"></i>
          </a>
          <div class="icon-bts" @click="saveDeleteRowId(props.formattedRow['id'])" data-tooltip="tooltip" data-toggle="modal" data-target="#deleteModal" title="刪除">
            <i class="fa fa-eraser"></i>
          </div>
        </span>
        <span v-else>
          {{props.formattedRow[props.column.field]}}
        </span>
      </template>
    </vue-good-table>
  </div>
</template>
<script>
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
          width: '70px',
        },
        {
          label: '管理人',
          field: 'users',
        },
        {
          label: '',
          field: 'actions',
          width: '135px',
        },
      ],
      deleteRowId: -1,
    };
  },
  methods: {
    saveDeleteRowId(rowId) {
      this.deleteRowId = rowId;
    },
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
    rowStyleClassFn(row) {

    },
  },
  computed: {
    rows() {
      return this.departmentList.map(department => {
        department.users = this.users.filter(user => user.department.id === department.id)
          .map(user => user.full_name)
          .join('、');
        department.actions = 'actions';
        return department;
      });
    },
  },
  mounted() {
    this.getDepartmentList();
    this.getUsers();
  },
  props: ['role', 'csrf-token'],
}
</script>
