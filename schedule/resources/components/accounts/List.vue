<template>
  <div>
    <!-- modal - del user -->
    <div class="modal fade" id="modalDelete" tabindex="-1" role="dialog" aria-hidden="true"
    data-backdrop="static">
      <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
          <div class="modal-header border-bottom-0">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"
            @click="cancelDeletion()">
              <span aria-hidden="true">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path d="M24 20.188l-8.315-8.209 8.2-8.282-3.697-3.697-8.212 8.318-8.31-8.203-3.666 3.666 8.321 8.24-8.206 8.313 3.666 3.666 8.237-8.318 8.285 8.203z"/></svg>
              </span>
            </button>
          </div>
          <div class="modal-body text-center pt-0">
            <h3 class="modal-title mb-4">刪除確認</h3>
            <p class="mb-4">確認要刪除 人員-{{deleteUser.fullName}} 嗎？</p>
            <div class="row">
              <div class="col mb-2">
                <button class="btn btn-rgenda" type="button"
                @click="cancelDeletion()"
                data-dismiss="modal">取消</button>
                <button id="btn-delete" class="btn btn-rgenda"
                @click="destory()"
                type="button">刪除</button>
              </div>
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
        <template v-else-if="props.column.field == 'functions'">
          <a :href="'/accounts/' + props.row.id" class="btn icon-bts" data-tooltip="tooltip" title="編輯">
            <i class="fas fa-edit"></i>
          </a>
          <button class="btn icon-bts" type="button" data-toggle="modal" data-target="#modalDelete"
          data-tooltip="tooltip" title="刪除" @click="comfirmDeletion(props.row)"><i class="fa fa-trash-alt"></i></button>
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
      deleteUser: {
        id: 0,
        fullName: '',
      },
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
          field: 'fullName',
        },
        {
          label: '職級',
          field: 'level',
        },
        {
          label: '排班身份',
          field: 'typeOfUser',
        },
        {
          label: '其他',
          field: 'pregnant',
          sortable: false,
        },
        {
          label: '排班狀況',
          field: 'canBeScheduled',
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
          fullName: obj.full_name,
          level: obj.level,
          typeOfUser: obj.type_of_user,
          pregnant: obj.pregnant,
          canBeScheduled: obj.can_be_scheduled,
        };
        return element;
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

      self.rows = self.rows.filter(function(obj) {
        return obj.id !== self.deleteUser.id;
      });

      $('#modalDelete').modal('hide')
    },
    cancelDeletion() {
      this.deleteUser = {
        id: 0,
        fullName: '',
      };
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
