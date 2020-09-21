<template>
  <div>
    <div class="card mb-4">
      <div class="card-header">
        <h4>基本設定</h4>
      </div>
      <div class="card-body">
        <div class="form-group">
          <label for="department-name">簡稱</label>
          <input type="text" class="form-control" id="department-name" v-model="department.name">
        </div>
        <div class="form-group">
          <label for="department-detail">科別名稱</label>
          <input type="text" class="form-control" id="department-detail" v-model="department.detail">
        </div>
        <div class="form-group">
          <label for="department-manager1">管理者1</label>
          <user-search-input
          id="department-manager1"
          v-model="department.managers.manager1"
          label-key="full_name"
          :item-list="userList" />
        </div>
        <div class="form-group">
          <label for="department-manager2">管理者2</label>
          <user-search-input
          id="department-manager2"
          v-model="department.managers.manager2"
          label-key="full_name"
          :item-list="userList" />
        </div>
        <div class="form-group">
          <label for="department-limit-pre-schedule">預約休假數量</label>
          <input type="number" class="form-control" id="department-limit-pre-schedule" v-model="department.limit_pre_schedule">
        </div>
        <div class="form-group">
          <label for="department-deadline-pre-schedule">預約休假期限</label>
          <input type="number" class="form-control" id="department-deadline-pre-schedule" max="28" v-model="department.deadline_pre_schedule">
        </div>
        <div class="form-group">
          <label for="department-can-rest-redday">週末及國定假日可休數量</label>
          <input type="number" class="form-control" id="department-can-rest-redday" v-model="department.can_rest_redday">
        </div>
        <div class="form-group mb-2">
          <label for="department-same-day-notice">預約休假日人數過多提示</label>
          <input type="number" class="form-control" id="department-save-day-notice" min="0" v-model="department.same_day_notice">
        </div>
        <div class="form-group">
          <label for="department-reset">時數重置規則</label>
          <select class="form-control" id="department-reset" v-model="department.reset">
            <option value="0">每年(1日)</option>
            <option value="1">每月(1日)</option>
          </select>
        </div>
        <div class="form-group">
          <label for="department-start-of-week">週起始日</label>
          <select class="form-control" id="department-start-of-week" v-model="department.start_of_week">
            <option value="0">星期日</option>
            <option value="1">星期一</option>
          </select>
        </div>
      </div>
    </div>
    <div class="card mb-4">
      <div class="card-header">
        <h4>勞基法相關規則</h4>
      </div>
      <div class="card-body">
        <div class="form-group">
          <label for="department-law-rule">勞基法工時規則</label>
          <select class="form-control" id="department-law-rule" v-model="department.law_rule">
            <option value="0">一般工時（7休2）</option>
            <option value="1">雙週變形工時（14休4）</option>
            <option value="2">四周變形工時（28休8）</option>
            <option value="3">八週變形工時（56休16）</option>
          </select>
        </div>
        <div class="form-group">
          <label for="department-date-start">起始日期</label>
          <date-picker
          id="department-date-start"
          v-model="department.date_start"
          :masks="{L: 'YYYY-MM-DD'}"
          :is-required="true"
          :popover="{visibility: 'focus'}">
          </date-picker>
        </div>
        <div class="form-group">
          <label for="department-overtime-rule">加班規則</label>
          <select class="form-control" id="department-overtime-rule" v-model="department.overtime_rule">
            <option value="0">單月46小時</option>
            <!-- <option value="1">三個月138小時</option> -->
          </select>
        </div>
      </div>
    </div>
    <div class="card mb-4">
      <div class="card-header">
        <h4>醫院排班規則</h4>
      </div>
      <div class="card-body">
        <div class="form-group">
          <label for="department-schedule-rule">班種設定</label>
          <select class="form-control" id="department-schedule-rule" v-model="department.schedule_rule">
            <!-- <option value="0">單週同班種</option> -->
            <option value="1">單月同班種</option>
            <!-- <option value="2">三月同班種</option> -->
          </select>
        </div>
        <div class="form-check mb-2">
          <input type="checkbox" class="form-check-input" id="department-admin-in-schedule" v-model="department.admin_in_schedule">
          <label class="form-check-label" for="department-admin-in-schedule">管理者是否排班</label>
        </div>
      </div>
    </div>
    <button type="button" class="btn btn-rgenda" @click="cancel()">取消</button>
    <button type="button" class="btn btn-rgenda" @click="save()">儲存</button>
  </div>
</template>
<script>
import popup from 'common/popup';
import moment from 'moment';
import DatePicker from 'v-calendar/lib/components/date-picker.umd';
import UserSearchInput from './UserSearchInput';
import {cloneDeep, isEmpty} from 'lodash';

export default {
  components: {
    DatePicker,
    UserSearchInput
  },
  data() {
    return {
      department: {
        managers: {
          manager1: {},
          manager2: {},
        },
      },
      userList: [],
    }
  },
  props: {
    departmentId: {
      type: Number,
      default: 0,
    },
    csrfToken: {
      type: String,
      default: '',
    },
  },
  methods: {
    init() {
      let self = this;
      Promise.all([
        this.$httpClient.get('/api/departments/'+this.departmentId+'/'),
        this.$httpClient.get('/api/users/?department=' + this.departmentId),
      ]).then(responses => {
        let department = responses[0].data;
        department.date_start = moment(department.date_start).toDate();
        department.original_managers = cloneDeep(department.managers);
        if (!department.managers.manager1) {
          department.managers.manager1 = {};
        }
        if (!department.managers.manager2) {
          department.managers.manager2 = {};
        }
        self.department = department;

        let userList = responses[1].data;
        if (Array.isArray(userList)) {
          self.userList = userList.filter(i => [0, 1, 2].indexOf(i.type_of_user) >= 0);
        } else {
          self.userList = userList;
        }
      }).catch((err) => {
        console.log(err);
      });
    },
    cancel() {
      history.back();
    },
    save() {
      if (!this.validate()) {
        popup.warning({
          title: '驗證錯誤',
          text: '請檢查所有欄位是否已填寫',
        });
        return false;
      }
      const formConfig = {
        headers: {
          'X-CSRFToken': `${this.csrfToken}`,
          'content-type': 'application/json',
        },
      };
      const departmentData = {
        name: this.department.name,
        detail: this.department.detail,
        limit_pre_schedule: this.department.limit_pre_schedule,
        deadline_pre_schedule: this.department.deadline_pre_schedule,
        can_rest_redday: this.department.can_rest_redday,
        reset: this.department.reset,
        start_of_week: this.department.start_of_week,
        date_start: moment(this.department.date_start).format('YYYY-MM-DD'),
        law_rule: this.department.law_rule,
        overtime_rule: this.department.overtime_rule,
        schedule_rule: this.department.schedule_rule,
        admin_in_schedule: this.department.admin_in_schedule,
        same_day_notice: this.department.same_day_notice,
      };
      const departmentManagerData = {
        department: this.departmentId,
        manager_one: this.department.managers.manager1.id || null,
        manager_two: this.department.managers.manager2.id || null,
      };

      popup.loading({
        title: '處理中...',
      });

      let self = this;
      let departmentManagerPromise = null;
      if (isEmpty(this.department.original_managers)) {
        // 若原本資料不存在，直接新增一筆
        departmentManagerPromise = this.$httpClient.post('/api/department-manager/', departmentManagerData, formConfig);
      } else {
        // 若原本資料存在，查詢對應departmentId的`account_departmentmanager`.`id`，並且更新資料內容
        departmentManagerPromise = this.$httpClient.get('/api/department-manager/')
          .then(response => {
            const departmentManager = response.data.find(i => i.department === self.departmentId);
            if (departmentManager) {
              return this.$httpClient.patch('/api/department-manager/' + departmentManager.id + '/', departmentManagerData, formConfig);
            }
            return Promise.reject('No valid department-manager for update');
          });
      }
      Promise.all([
        this.$httpClient.patch('/api/departments/' + this.departmentId + '/', departmentData, formConfig),
        departmentManagerPromise,
      ]).then(() => {
        popup.success({
          title: '修改排班規則',
          text: '請求成功',
        }, () => {
          location.replace('/departments/list');
        });
      }).catch(errors => {
        popup.error({
          title: '修改排班規則',
          text: '請求失敗，請洽管理人員'
        });
        console.log(errors);
      });
    },
    validate() {
      if (this.department.name === ''
      || this.department.detail === ''
      || (isNaN(parseInt(this.department.managers.manager1.id)) && isNaN(parseInt(this.department.managers.manager2.id)))
      || this.department.limit_pre_schedule < 0 || this.department.limit_pre_schedule > 31
      || this.department.deadline_pre_schedule < 0 || this.department.deadline_pre_schedule > 29
      || this.department.can_rest_redday < 0
      || [0, 1].indexOf(parseInt(this.department.reset)) < 0
      || [0, 1].indexOf(parseInt(this.department.start_of_week)) < 0
      || !moment(this.department.date_start).isValid()
      || [0, 1, 2, 3].indexOf(parseInt(this.department.law_rule)) < 0
      || [0, 1].indexOf(parseInt(this.department.overtime_rule)) < 0
      || [0, 1, 2].indexOf(parseInt(this.department.schedule_rule)) < 0
      || [true, false].indexOf(this.department.admin_in_schedule) < 0
      || this.department.same_day_notice < 0) {
        return false;
      }
      return true;
    },
  },
  computed: {
    filteredUserList() {
      if (this.department.hasOwnProperty('managerSearch') && this.department.managerSearch !== '') {
        return this.userList.filter(user => user.full_name.indexOf(this.department.managerSearch));
      }
      return this.userList;
    },
  },
  mounted() {
    this.init();
  },
}
</script>
