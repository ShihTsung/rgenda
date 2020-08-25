<template>
  <div>
    <div class="row mb-2">
      <div class="col-12">
        <div class="float-right">
          <!-- 新增人力配置 -->
          <a href="#" class="btn icon-bts m-0" data-tooltip="tooltip" title="新增班別" data-toggle="modal" data-target="#modalAddShifts">
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
          <div class="icon-bts btn-sm" data-tooltip="tooltip" title="刪除" data-toggle="modal" data-target="#modalDeleteShits"
          @click="comfirmDeletion(props.row)"><i class="fa fa-trash-alt"></i></div>
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
      deleteShifts: {
        id: 0,
        fullName: '',
      },
      columns: [
        {
          label: '編號',
          field: 'id',
          type: 'number',
        },
        {
          label: '班別名稱',
          field: 'name',
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
      return data.filter(function(obj) {
        // 0 白班，1 小夜，2 大夜，4 oncall
        return [0, 1, 2, 4].includes(obj.shift_type);
      }).map(function(obj) {
        return {
          id: obj.id,
          name: obj.name,
          startTime: obj.start_time,
          endTime: obj.end_time,
          workHours: obj.work_hours,
        };
      });
    },
    comfirmDeletion(row) {
      this.deleteShifts = {
        id: row.id,
        fullName: row.fullName,
      };
    },
    cancelDeletion() {
      this.deleteShifts = {
        id: 0,
        fullName: '',
      };
    },
  },
  mounted() {
    this.getShifts();
  },
}
</script>
