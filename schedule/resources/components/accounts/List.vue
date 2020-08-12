<template>
  <div>
    <!-- modal - del user -->
    <div class="modal fade" id="modalDelete" tabindex="-1" role="dialog" aria-hidden="true"
    data-backdrop="static">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h3 class="modal-title" id="exampleModalScrollableTitle">刪除使用者</h3>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <p>確定刪除？</p>
            <div class="row">
              <div class="col text-right"><button class="btn btn-primary" type="button"
                @click="cancelDeletion()"
                data-dismiss="modal">取消</button></div>
              <div class="col text-left"><button id="btn-delete" class="btn btn-danger"
              @click="destory()"
                type="button">刪除</button></div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- \modal - del user -->

    <!-- users table -->
    <vue-good-table v-if="loading"
      :columns="columns"
      :rows="rows"
      :search-options="{
        enabled: true,
      }">
      <template slot="table-row" slot-scope="props">
        <template v-if="props.column.field == 'can_be_scheduled'">
          <div class="form-check">
            <input class="form-check-input" type="checkbox" value="" :id="'can_be_scheduled_' + props.row.id"
            @change="changeSchedule(props.row.id, props.row.username, !props.row.can_be_scheduled)"
            :checked="props.row.can_be_scheduled">
            <label class="form-check-label" :for="'can_be_scheduled_' + props.row.id">
              正常排班
            </label>
        </div>
        </template>
        <template v-else-if="props.column.field == 'functions'">
          <a :href="'/accounts/' + props.row.id" class="btn icon-bts" data-tooltip="tooltip" title="編輯">
            <i class="fas fa-edit"></i>
          </a>
          <button class="btn icon-bts" type="button" data-toggle="modal" data-target="#modalDelete"
          data-tooltip="tooltip" title="刪除" @click="comfirmDeletion(props.row.id)"><i class="fa fa-trash-alt"></i></button>
        </template>
      </template>
    </vue-good-table>
    <div v-if="noData">
      <div class="row col-12 text-center">
        <p class="form-control-plaintext">無資料</p>
      </div>
    </div>
    <!-- \users table -->
  </div>
</template>

<script>
import popup from 'common/popup';
import {
  httpRep
} from 'common/helpers';
import 'vue-good-table/dist/vue-good-table.css'
import { VueGoodTable } from 'vue-good-table';

export default {
  components: {
    VueGoodTable,
  },
  props: {
    role: {
      type: String,
      default: '',
    },
    isSuperuser: {
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
      loading: false,
      noData: false,
      deleteId: 0,
      columns: [
        {
          label: '部門',
          field: 'department',
        },
        {
          label: '員工編號',
          field: 'eid',
        },
        {
          label: '姓名',
          field: 'full_name',
        },
        {
          label: '職級',
          field: 'level',
        },
        {
          label: '排班身份',
          field: 'type_of_user',
        },
        {
          label: '其他',
          field: 'pregnant',
          sortable: false,
        },
        {
          label: '排班狀況',
          field: 'can_be_scheduled',
          sortable: false,
        },
        {
          label: '功能',
          field: 'functions',
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
      let url = `/api/users/?mode=table`;
      this.$httpClient.get(url)
        .then(function (response) {
          let data = response.data;
          if (data.length > 0) {
            self.transformer(data);
            self.loading = true;
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
            html: typeof error.message === 'string' ? error.message : httpRep.messageJoin(error.message),
          });
          console.log(error);
        });
    },
    transformer(data) {
      let newArr = [];
      this.rows = data.map(function(obj) {
        let element = {
          id: obj.id,
          username: obj.username,
          department: obj.department.detail,
          eid: obj.eid,
          full_name: obj.full_name,
          level: obj.level,
          type_of_user: obj.type_of_user,
          pregnant: obj.pregnant,
          can_be_scheduled: obj.can_be_scheduled,
        };
        return element;
      });
    },
    comfirmDeletion(id) {
      this.deleteId = id;
    },
    destory() {
      let self = this;

      // self.rows.splice(self.deleteId, 1);
      self.rows = self.rows.filter(function(obj) {
        return obj.id !== self.deleteId;
      });

      $('#modalDelete').modal('hide')
    },
    cancelDeletion() {
      this.deleteId = 0;
    },
    changeSchedule(id, username, bool) {
      let self = this;
      let url = `/api/users/${id}/`;
      let params = {
        username: username,
        can_be_scheduled: bool,
      };
      const formConfig = {
        headers: {
          'X-CSRFToken': `${this.csrfToken}`
        }
      };

      popup.loading({
        title: "處理中...",
      });

      this.$httpClient.patch(url, params, formConfig)
        .then(function (response) {
          popup.success({
            title: "更新排班狀況",
            text: "請求成功",
          });
        })
        .catch(function (error) {
          // handle error
          popup.error({
            title: error.title,
            html: typeof error.message === 'string' ? error.message : httpRep.messageJoin(error.message),
          });
          console.log(error);
        });
    },
  },
  mounted() {
    this.getUsers();
  }
}
</script>

<style scoped>

</style>
