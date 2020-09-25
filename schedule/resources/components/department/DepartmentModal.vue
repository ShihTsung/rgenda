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
        <div class="modal-body text-left pt-0">
          <h3 class="modal-title mb-4 mx-">科別內容</h3>
          <div class="mx-4">
            <div class="mb-2" v-for="column in columns"
            :key="column.field"
            v-show="column.label !== '' && computedRow.hasOwnProperty(column.field)">
              <div class="font-weight-bold">{{ column.label }}：</div>
              <div v-if="column.const">{{ getConstString(column) }}</div>
              <div v-else>{{ computedRow[column.field] }}</div>
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
          field: 'manager1',
        },
        {
          label: '管理人2',
          field: 'manager2',
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
          const: '$getResetTypeString',
        },
        {
          label: '週起始日',
          field: 'start_of_week',
          const: '$getStartOfWeekString',
        },
        {
          label: '勞基法工時規則',
          field: 'law_rule',
          const: '$getLawRuleString',
        },
        {
          label: '加班規則',
          field: 'overtime_rule',
          const: '$getOvertimeRuleString',
        },
        {
          label: '班種設定',
          field: 'schedule_rule',
          const: '$getScheduleRuleString',
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
          label: '起算日期',
          field: 'start_date',
        }
      ],
    }
  },
  methods: {
    getConstString(column) {
      return this[column.const](this.computedRow[column.field]);
    },
  },
  computed: {
    computedRow() {
      if (this.rowData.managers) {
        return Object.assign(this.rowData, {
          manager1: this.rowData.managers.manager1 ? this.rowData.managers.manager1.name : '',
          manager2: this.rowData.managers.manager2 ? this.rowData.managers.manager2.name : '',
        })
      }
      return this.rowData;
    },
  },
  props: ['rowData'],
}
</script>
