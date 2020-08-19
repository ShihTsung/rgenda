<template>
<div>
  <div class="col-12 bg-white">
    <div class="form-group">
      <h4 class="rgenda-text-dark-blue">記錄查詢</h4>
    </div>
  </div>
  <div class="mt-5">
    <hr class="">
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
          @click="comfirmDeletion(props.row)"><i class="fa fa-trash-alt"></i></div>
        </template>
      </template>
    </vue-good-table>
    <!-- \users table -->
  </div>
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
    csrfToken: {
      type: String,
      default: '',
    },
  },
  data() {
    return {
      loaded: false,
      columns: [
        {
          label: '編號',
          field: 'id',
          sortable: false,
        },
        {
          label: '類別',
          field: 'eid',
          sortable: false,
        },
        {
          label: '日期',
          field: 'fullName',
        },
        {
          label: '時數',
          field: 'level',
          sortable: false,
        },
        {
          label: '姓名',
          field: 'typeOfUser',
          sortable: false,
        },
        {
          label: '備註',
          field: 'pregnant',
          sortable: false,
        },
        {
          label: '動作',
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
    transformer(data) {
      let self = this;
      return data.map(function(obj) {
        return {
          id: obj.id,
          username: obj.username,
          department: obj.department.detail,
          eid: obj.eid,
          fullName: obj.full_name,
          level: obj.level,
          // typeOfUser: self.$getUserTypeString(obj.type_of_user),
          pregnant: obj.pregnant,
          canBeScheduled: obj.can_be_scheduled,
        };
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
    // this.getUsers();
  },
}
</script>
