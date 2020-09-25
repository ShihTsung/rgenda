<template>
  <div>
    <!-- modal - del user -->
    <div class="modal fade" id="modalDelete" tabindex="-1" role="dialog" aria-hidden="true"
    data-backdrop="static">
      <div class="modal-dialog modal-dialog-centered">
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
            <h3 class="modal-title rgenda-text-dark-blue mb-4">刪除確認</h3>
            <p class="mb-4">確定要刪除 人員-{{deleteUser.fullName}} 嗎？</p>
            <div class="row">
              <div class="col mb-2">
                <button class="btn btn-rgenda" type="button"
                @click="cancelDeletion()"
                data-dismiss="modal">取消</button>
                <button id="btn-delete" class="btn btn-rgenda"
                @click="destroy()"
                type="button">刪除</button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- \modal - del user -->

    <!-- users table -->
    <vue-good-table v-if="loaded"
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
        <template v-else-if="props.column.field == 'actions'">
          <a class="icon-bts btn-sm" data-tooltip="tooltip" title="編輯"
          :href="'/accounts/' + props.row.id"><i class="fas fa-edit"></i></a>
          <div class="icon-bts btn-sm" data-tooltip="tooltip" title="刪除" data-toggle="modal" data-target="#modalDelete"
          @click="confirmDeletion(props.row)"><i class="fa fa-trash-alt"></i></div>
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
      loaded: false,
      noData: false,
      deleteUser: {
        id: 0,
        fullName: '',
      },
      columns: [
        {
          label: '科別',
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
          field: 'actions',
          sortable: false,
        },
      ],
      rows: [],
      rendered: false,
    };
  },
  methods: {
    isManager() {
      return ['admin', 'manager'].includes(this.role);
    },
    getUsers() {
      let self = this;
      let url = `/api/users/?mode=table`;
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
      return data.map(function(obj) {
        return {
          id: obj.id,
          username: obj.username,
          department: obj.department.name,
          eid: obj.eid,
          fullName: obj.full_name,
          level: obj.level,
          typeOfUser: self.$getUserTypeString(obj.type_of_user),
          pregnant: obj.pregnant,
          canBeScheduled: obj.can_be_scheduled,
        };
      });
    },
    confirmDeletion(row) {
      this.deleteUser = {
        id: row.id,
        fullName: row.fullName,
      };
    },
    destroy() {
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
        title: '處理中...',
      });

      this.$httpClient.patch(url, params, formConfig)
        .then(function (response) {
          popup.success({
            title: '更新排班狀況',
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
  },
  mounted() {
    this.getUsers();
  },
}
</script>
