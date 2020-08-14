<template>
  <div class="modal fade" id="infoModal" tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
      <div class="modal-content">
        <div class="modal-header border-bottom-0">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">
              <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path d="M24 20.188l-8.315-8.209 8.2-8.282-3.697-3.697-8.212 8.318-8.31-8.203-3.666 3.666 8.321 8.24-8.206 8.313 3.666 3.666 8.237-8.318 8.285 8.203z"/></svg>
            </span>
          </button>
        </div>
        <div class="modal-body text-center pt-0">
          <h3 class="modal-title mb-4">科別內容</h3>
          <div class="mb-4" v-for="column in columns" :key="column.field">
            <div class="row" v-if="column.label !== '' && rowData.hasOwnProperty(column.field)">
              <div class="col-sm-6 col-lg-3">{{column.label}}：</div>
              <div class="col-sm-6 col-lg-9">{{rowData[column.field]}}</div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      columns: [
        {
          label: '編號',
          field: 'id',
        },
        {
          label: '簡稱',
          field: 'name',
        },
        {
          label: '科別名稱',
          field: 'detail',
        },
        {
          label: '管理人1',
          field: 'user1',
        },
        {
          label: '管理人2',
          field: 'user2',
        },
        {
          label: '預約休假數量',
          field: 'limit_pre_schedule',
        },
        {
          label: '預約休假期限',
          field: 'deadline_pre_schedule',
        },
        {
          label: '時數重置規則',
          field: 'reset',
        },
        {
          label: '勞基法工時規則',
          field: 'law_rule',
        },
        {
          label: '加班規則',
          field: 'overtime_rule',
        },
        {
          label: '班種設定',
          field: 'shift_setting',
        },
        {
          label: '管理者是否排班',
          field: 'enable_admin_shift',
        },
        {
          label: '預約休假日人數過多提示',
          field: 'pre_schedule_warning',
        },
        {
          label: '週起始日',
          field: 'week_begin_date',
        },
        {
          label: '起算日期',
          field: 'start_date',
        }
      ],
    }
  },
  computed: {
    computedRow() {
      return this.rowData.map(field => {
        let newField = Object.assign({}, field, {
          user1: field.user1,
          user2: field.user2,
        });
      });
    },
  },
  props: ['rowData'],
}
</script>
