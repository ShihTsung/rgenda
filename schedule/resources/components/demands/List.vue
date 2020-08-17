<template>
  <div>
    <modal-delete-demand
    :csrf-token="csrfToken"
    :delete-shift="deleteShift"></modal-delete-demand>

    <div class="row mb-2">
      <div class="col-12">
        <div class="float-right">
          <!-- 新增人力配置 -->
          <a href="/demands/create" class="btn icon-bts m-0" data-tooltip="tooltip" title="新增人力配置">
            <svg xmlns="http://www.w3.org/2000/svg" class="icon-color" width="24" height="24" viewBox="0 0 24 24">
              <path d="M24 10h-10v-10h-4v10h-10v4h10v10h4v-10h10z"/></svg>
          </a>
          <!-- 、新增人力配置 -->
        </div>
      </div>
    </div>

    <div class="rol col-12 p-0" v-if="loaded && demands">
      <table class="table table-bordered text-center rgenda-table shadow-none">
        <thead>
          <tr>
            <th scope="col" rowspan="2">工作站名</th>
            <th scope="col" rowspan="2">班別</th>
            <th scope="col" colspan="2">可排人員</th>
            <th scope="col" colspan="3">配置一</th>
            <th scope="col" colspan="3">配置二</th>
            <th scope="col" rowspan="2" style="min-width: 120px">功能</th>
          </tr>
          <tr>
            <th scope="col">資深正職</th>
            <th scope="col">正職</th>
            <th scope="col">資深正職</th>
            <th scope="col">正職</th>
            <th scope="col">小計</th>
            <th scope="col">資深正職</th>
            <th scope="col">正職</th>
            <th scope="col">小計</th>
          </tr>
        </thead>
        <tbody>
          <template v-for="(station, idx) in demands">
            <tr v-for="shift in station" :key="['station', idx, shift.stationId, shift.shiftId].join('_')">
              <td>{{ shift.stationName }}</td>
              <td>{{ shift.shiftName }}</td>
              <td v-html="userNames(shift.config[$getUserLevelValue('VALUE_SENIOR')].people)"></td>
              <td v-html="userNames(shift.config[$getUserLevelValue('VALUE_NORMAL')].people)"></td>
              <td>{{ shift.config[$getUserLevelValue('VALUE_SENIOR')].config1 }}</td>
              <td>{{ shift.config[$getUserLevelValue('VALUE_NORMAL')].config1 }}</td>
              <td>{{ usersOfConfig(shift.config[$getUserLevelValue('VALUE_SENIOR')].config1, shift.config[$getUserLevelValue('VALUE_NORMAL')].config1) }}</td>
              <td>{{ shift.config[$getUserLevelValue('VALUE_SENIOR')].config2 }}</td>
              <td>{{ shift.config[$getUserLevelValue('VALUE_NORMAL')].config2 }}</td>
              <td>{{ usersOfConfig(shift.config[$getUserLevelValue('VALUE_SENIOR')].config1, shift.config[$getUserLevelValue('VALUE_NORMAL')].config2) }}</td>
              <td>
                <div class="icon-bts btn-sm" data-tooltip="tooltip" title="編輯">
                  <i class="fas fa-edit"></i>
                </div>
                <div class="icon-bts btn-sm" data-tooltip="tooltip" title="刪除" data-toggle="modal" data-target="#modalDeleteShift"
                @click="comfirmDeletion(shift)">
                  <i class="fa fa-trash-alt"></i></div>
              </td>
            </tr>
          </template>
        </tbody>
      </table>
    </div>

    <div v-if="noData">
      <div class="row col-12 text-center">
        <p class="form-control-plaintext">無資料</p>
      </div>
    </div>

  </div>
</template>

<script>
import popup from 'common/popup';
import {
  httpRep
} from 'common/helpers';
import ModalDeleteDemand from './ModalDeleteDemand.vue';

export default {
  components: {
    ModalDeleteDemand,
  },
  props: {
    userId: {
      type: Number,
      default: 0,
    },
    username: {
      type: String,
      default: '',
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
      demands: [],
      users: [],
      rendered: false,
      deleteShift: {
        demandIds: [],
        stationName: '',
        shiftName: '',
      }
    };
  },
  methods: {
    objectLength(obj) {
      let keys = Object.keys(obj);
      let size = 0;
      keys.forEach(function(key) {
        if (!isNaN(Number(key))) {
          ++size;
        }
      });

      return size || 0;
    },
    getNormalUsers() {
      let type = this.$getUserTypeValue('VALUE_NORMAL');
      this.getUsers(type);
    },
    getSeniorlUsers() {
      let type = this.$getUserTypeValue('VALUE_NORMAL');
      this.getUsers(type);
    },
    getUsers(type) {
      type = type || '';

      let self = this;
      let url = `/api/users/` + type;
      this.$httpClient.get(url)
        .then(function (response) {
          let data = response.data;
          if (data.length > 0) {
            // self.users = self.usersTransformer(data);
          } else {
            self.users = [];
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
    usersTransformer(data) {
      let newArr = [];
      return data.map(function (obj) {
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
    getDemands() {
      let self = this;
      let url = `/api/demands/`;
      this.$httpClient.get(url)
        .then(function (response) {
          let data = response.data;
          if (data.length > 0) {
            self.demands = self.demandsTransformer(data);
            self.loaded = true;
            self.noData = false;
          } else {
            self.demands = [];
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
    demandsTransformer(arrObj) {
      // example
      // arrObj = [{"id":1,"shift":{"id":10,"name":"B10","shift_type":0,"start_time":"08:00:00","end_time":"16:30:00","department":1,"work_hours":8},"config1":1,"config2":1,"station":{"id":1,"name":"POR主控","department":1},"level":1,"people":[]},{"id":2,"shift":{"id":10,"name":"B10","shift_type":0,"start_time":"08:00:00","end_time":"16:30:00","department":1,"work_hours":8},"config1":0,"config2":0,"station":{"id":1,"name":"POR主控","department":1},"level":2,"people":[]},{"id":31,"shift":{"id":11,"name":"B15","shift_type":0,"start_time":"08:03:00","end_time":"12:30:00","department":1,"work_hours":4},"config1":1,"config2":1,"station":{"id":1,"name":"POR主控","department":1},"level":1,"people":[]},{"id":32,"shift":{"id":11,"name":"B15","shift_type":0,"start_time":"08:03:00","end_time":"12:30:00","department":1,"work_hours":4},"config1":0,"config2":0,"station":{"id":1,"name":"POR主控","department":1},"level":2,"people":[]}];
      // result
      // {"1":{"10":{"id":10,"name":"B10","config":{"1":{"id":1,"shift":{"id":10,"name":"B10","shift_type":0,"start_time":"08:00:00","end_time":"16:30:00","department":1,"work_hours":8},"config1":1,"config2":1,"station":{"id":1,"name":"POR主控","department":1},"level":1,"people":[]},"2":{"id":2,"shift":{"id":10,"name":"B10","shift_type":0,"start_time":"08:00:00","end_time":"16:30:00","department":1,"work_hours":8},"config1":0,"config2":0,"station":{"id":1,"name":"POR主控","department":1},"level":2,"people":[]}}},"11":{"id":11,"name":"B15","config":{"1":{"id":31,"shift":{"id":11,"name":"B15","shift_type":0,"start_time":"08:03:00","end_time":"12:30:00","department":1,"work_hours":4},"config1":1,"config2":1,"station":{"id":1,"name":"POR主控","department":1},"level":1,"people":[]},"2":{"id":32,"shift":{"id":11,"name":"B15","shift_type":0,"start_time":"08:03:00","end_time":"12:30:00","department":1,"work_hours":4},"config1":0,"config2":0,"station":{"id":1,"name":"POR主控","department":1},"level":2,"people":[]}}},"id":1,"name":"POR主控"}}

      let demands = {};
      arrObj.forEach(function (obj, idx) {
        let prop = [obj.station.id, obj.shift.id].join('_');
        if (!demands.hasOwnProperty(obj.station.id)) {
          let key = obj.shift.id;
          demands = {
            [obj.station.id]: {
              [obj.shift.id]: {
                stationId: obj.station.id,
                stationName: obj.station.name,
                shiftId: obj.shift.id,
                shiftName: obj.shift.name,
                config: {},
              },
            },
          };
          // group by level
          Object.assign(demands[obj.station.id][obj.shift.id].config, {
            [obj.level]: obj
          });
        } else {
          if (demands[obj.station.id].hasOwnProperty(obj.shift.id)) {
            // group by level
            Object.assign(demands[obj.station.id][obj.shift.id].config, {
              [obj.level]: obj
            });
          } else {
            Object.assign(demands[obj.station.id], {
              [obj.shift.id]: {
                stationId: obj.station.id,
                stationName: obj.station.name,
                shiftId: obj.shift.id,
                shiftName: obj.shift.name,
                config: {},
              },
            });
            // group by level
            Object.assign(demands[obj.station.id][obj.shift.id].config, {
              [obj.level]: obj
            });
          }
        }
      });

      return demands;
    },
    comfirmDeletion(shift) {
      let demandIds = [];
      for (const [key, value] of Object.entries(shift.config)) {
        demandIds.push(value.id)
      }
      this.deleteShift = {
        demandIds: demandIds,
        stationName: shift.stationName,
        shiftName: shift.shiftName,
      };
    },
    cancelDeletion() {
      this.deleteShift = {
        demandIds: [],
        stationName: '',
        shiftName: '',
      };
    },
    changeSchedule(id, username, bool) {
      let self = this;
      let url = `/api/demands/${id}/`;
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
    usersOfConfig(config1, config2) {
      return Number(config1) + Number(config2);
    },
    userNames(arrObj) {
      return arrObj.map(function(user) {
        return user.full_name;
      }).join('<br>');
    },
  },
  mounted() {
    this.getDemands();
    this.getUsers();
  },
}
</script>
