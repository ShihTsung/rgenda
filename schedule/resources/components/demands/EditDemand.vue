<template>
  <div class="card">
    <div class="card-body">
      <h4 class="card-title mb-3">{{ editShift.stationName}} 班別 {{ editShift.shiftName }} 的人員配置</h4>
      <div class="accordion">
        <!-- 可排人員 -->
        <div class="card">
          <div class="card-header">
            <h5 class="mb-0">可排人員</h5>
          </div>
          <div class="card-body">
            <div class="row col-md-12">
              <div class="form-group col-md-6">
                <label for="exampleInputEmail1">資深正職</label>
                <div class="form-group">
                  <div class="form-check form-check-inline"
                  v-for="user in seniorStaff" :key="['senior_staff', user.id].join('_')">
                    <input class="form-check-input" type="checkbox"
                    :id="['chk_senior_staff', user.id].join('_')"
                    v-model="seniorDemandOfShift.checkedUserIds"
                    :value="user.id">
                    <label class="form-check-label" :for="['chk_senior_staff', user.id].join('_')">{{ user.full_name }}</label>
                  </div>
                </div>
              </div>
              <div class="form-group col-md-6">
                <label for="exampleInputPassword1">正職</label>
                <div class="form-group">
                  <div class="form-check form-check-inline"
                  v-for="user in normalStaff" :key="['normal_staff', user.id].join('_')">
                    <input class="form-check-input" type="checkbox"
                    :id="['chk_normal_staff', user.id].join('_')"
                    v-model="normalDemandOfShift.checkedUserIds"
                    :value="user.id">
                    <label class="form-check-label" :for="['chk_normal_staff', user.id].join('_')">{{ user.full_name }}</label>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- \可排人員 -->

        <!-- 配置一 -->
        <div class="card">
          <div class="card-header">
            <h5 class="mb-0">配置一</h5>
          </div>
          <div class="card-body">
            <div class="row col-md-12">
              <div class="form-group col-md-4">
                <label for="">資深正職</label>
                <input type="number" class="form-control" v-model="seniorDemandOfShift.config1">
              </div>
              <div class="form-group col-md-4">
                <label for="">正職</label>
                <input type="number" class="form-control" v-model="normalDemandOfShift.config1">
              </div>
              <div class="form-group col-md-4">
                <label for="">小計</label>
                <input type="text" readonly class="form-control-plaintext" v-model="configSubtotal1">
              </div>
            </div>
          </div>
        </div>
        <!-- \配置一 -->
        <!-- 配置二 -->
        <div class="card">
          <div class="card-header">
            <h5 class="mb-0">配置二</h5>
          </div>
          <div class="card-body">
            <div class="row col-md-12">
              <div class="form-group col-md-4">
                <label for="">資深正職</label>
                <input type="number" class="form-control" v-model="seniorDemandOfShift.config2">
              </div>
              <div class="form-group col-md-4">
                <label for="">正職</label>
                <input type="number" class="form-control" v-model="normalDemandOfShift.config2">
              </div>
              <div class="form-group col-md-4">
                <label for="">小計</label>
                <input type="text" readonly class="form-control-plaintext" v-model="configSubtotal2">
              </div>
            </div>
          </div>
        </div>
        <!-- \配置二 -->
      </div>
      <div class="col-md-12 mt-3">
        <div class="form-group text-center mb-0">
          <button class="btn btn-rgenda" @click="cancelEdit()">取消</button>
          <button class="btn btn-rgenda" @click="update()">儲存</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import _ from 'lodash';
import popup from 'common/popup';
import {
  httpRep
} from 'common/helpers';

export default {
  props: {
    csrfToken: {
      type: String,
      default: '',
    },
    editShift: {
      type: Object,
      default: {
        stationId: 0,
        stationName: '',
        shiftId: 0,
        shiftName: '',
        config: {},
      }
    }
  },
  data() {
    return {
      seniorStaff: [],
      normalStaff: [],

      normalDemandOfShift: {
        demandId: 0,
        config1: 0,
        config2: 0,
        level: 0,
        checkedUserIds: [],
        assignedUsers: [],
      },
      seniorDemandOfShift: {
        demandId: 0,
        config1: 0,
        config2: 0,
        level: 0,
        checkedUserIds: [],
        assignedUsers: [],
      },

    };
  },
  methods: {
    cancelEdit() {
      this.seniorStaff = [];
      this.normalStaff = [];
      this.normalDemandOfShift = {
        demandId: 0,
        config1: 0,
        config2: 0,
        level: 0,
        checkedUserIds: [],
        assignedUsers: [],
      };
      this.seniorDemandOfShift = {
        demandId: 0,
        config1: 0,
        config2: 0,
        level: 0,
        checkedUserIds: [],
        assignedUsers: [],
      };

      this.$parent.cancelEdit();
    },
    getNormalUsers() {
      let type = this.$getUserTypeValue('VALUE_NORMAL');
      this.$_editDemand_getUsers(type);
    },
    getSeniorlUsers() {
      let type = this.$getUserTypeValue('VALUE_SENIOR');
      this.$_editDemand_getUsers(type);
    },
    $_editDemand_getUsers(type) {
      let self = this;
      let url = `/api/users/?type=` + type;
      this.$httpClient.get(url)
        .then(function (response) {
          let data = response.data;
          if (data.length > 0) {
            if (self.$getUserTypeValue('VALUE_NORMAL') === type) {
              self.normalStaff = data;
            } else {
              self.seniorStaff = data;
            }
          } else {
            if (self.$getUserTypeValue('VALUE_NORMAL') === type) {
              self.normalStaff = [];
            } else {
              self.seniorStaff = [];
            }
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
    $_editDemand_validate() {
      let bool = true;
      let errMsg = [];
      if (this.seniorDemandOfShift.checkedUserIds.length < 1 && this.normalDemandOfShift.checkedUserIds.length < 1) {
        errMsg.push('「可排人員」未正確選取');
        bool = false;
      }
      if (Number(this.configSubtotal1) < 1) {
        errMsg.push('「配置一」小計不得為 0');
        bool = false;
      }
      if (Number(this.configSubtotal2) < 1) {
        errMsg.push('「配置二」小計不得為 0');
        bool = false;
      }

      return [bool, errMsg];
    },
    $_editDemand_delUerIds(demandId, userIdArr, arrObj) {
      let delUserIds = [];
      arrObj.forEach(user => {
        if (!userIdArr.includes(user.id)) {
          delUserIds.push([user.demand_user_id, demandId, user.id, ])
        }
      });

      return delUserIds;
    },
    $_editDemand_addUerIds(demandId, userIdArr, arrObj) {
      let addUerIds = [];
      userIdArr.forEach(id => {
        if (!_.find(arrObj, function (user) {
            return user.id == id;
          })
        ) {
          addUerIds.push([demandId, id])
        }
      });

      return addUerIds;
    },
    update() {
      let [bool, errMsg] = this.$_editDemand_validate();
      if (!bool) {
        popup.error({
          title: '驗證錯誤',
          html: httpRep.messageJoin(errMsg),
        });
        return false;
      }

      let self = this;
      let changed = false;
      let delNormalUsers = [];
      let delSeniorUsers = [];
      delNormalUsers = self.$_editDemand_delUerIds(
        self.normalDemandOfShift.demandId,
        self.normalDemandOfShift.checkedUserIds,
        self.normalDemandOfShift.assignedUsers
      );
      delSeniorUsers = self.$_editDemand_delUerIds(
        self.seniorDemandOfShift.demandId,
        self.seniorDemandOfShift.checkedUserIds,
        self.seniorDemandOfShift.assignedUsers
      );
      // console.log([...delNormalUsers, ...delSeniorUsers]);
      let delUserPromiseArr = [...delNormalUsers, ...delSeniorUsers].map(item => {
        changed = true;
        let url = `/api/demand-user/${item[0]}/`;
        const formConfig = {
          headers: {
            'X-CSRFToken': `${self.csrfToken}`
          }
        }
        self.$httpClient.delete(url, formConfig)
          .then(function (response) {
            // debug
            // console.log(`delete demand_user_id = ${item[0]}`);
          })
          .catch(function (error) {
            // handle error
            popup.error({
              title: error.title,
              html: httpRep.messageJoin(error.message),
            });
            console.log(error);
          });
      });

      let addNormalUsers = [];
      let addSeniorUsers = [];
      addNormalUsers = self.$_editDemand_addUerIds(
        self.normalDemandOfShift.demandId,
        self.normalDemandOfShift.checkedUserIds,
        self.normalDemandOfShift.assignedUsers
      );
      addSeniorUsers = self.$_editDemand_addUerIds(
        self.seniorDemandOfShift.demandId,
        self.seniorDemandOfShift.checkedUserIds,
        self.seniorDemandOfShift.assignedUsers
      );
      let addUserPromiseArr = [...addNormalUsers, ...addSeniorUsers].map(item => {
        changed = true;
        let url = `/api/demand-user/`;
        const formConfig = {
          headers: {
            'X-CSRFToken': `${self.csrfToken}`
          }
        }
        let params = {
          demand: item[0],
          user: item[1],
        };
        self.$httpClient.post(url, params, formConfig)
          .then(function (response) {
            // debug
            // console.log(`create demand id = ${item[0]}, user id = ${item[1]}`);
          })
          .catch(function (error) {
            // handle error
            popup.error({
              title: error.title,
              html: httpRep.messageJoin(error.message),
            });
            console.log(error);
          });
      });

      let configPromisedArr = [self.normalDemandOfShift, self.seniorDemandOfShift].map(function (obj) {
        if (obj.originConfig1 === Number(obj.config1) && obj.originConfig2 === Number(obj.config2)) {
          // if there are no changes, skip
          return;
        }

        changed = true;
        let url = `/api/demands/${obj.demandId}/`;
        const formConfig = {
          headers: {
            'X-CSRFToken': `${self.csrfToken}`
          }
        }
        let params = {
          id: obj.demandId,
          station: self.editShift.stationId,
          shift: self.editShift.shiftId,
          config1: obj.config1,
          config2: obj.config2,
          level: obj.level,
        };
        self.$httpClient.patch(url, params, formConfig)
          .then(function (response) {
            // debug
            // console.log(`update demand id = ${id}`);
          })
          .catch(function (error) {
            // handle error
            popup.error({
              title: error.title,
              html: httpRep.messageJoin(error.message),
            });
            console.log(error);
          });
      });

      Promise.all([
        ...delUserPromiseArr,
        ...addUserPromiseArr,
        ...configPromisedArr
      ]).then(function (response) {
        if (changed) {
          popup.success({
            title: '編輯人力配置',
            text: '請求成功',
          }, function () {
            self.cancelEdit();
            // refresh demand list if changed
            self.$parent.getDemands();
          });
        } else {
          self.cancelEdit();
        }
      }).catch(function (error) {
        // handle error
        popup.error({
          title: error.title,
          html: httpRep.messageJoin(error.message),
        });
        console.log(error);
      });
    },
  },
  computed: {
    configSubtotal1() {
      return Number(this.seniorDemandOfShift.config1) + Number(this.normalDemandOfShift.config1);
    },
    configSubtotal2() {
      return Number(this.seniorDemandOfShift.config2) + Number(this.normalDemandOfShift.config2);
    },
  },
  mounted() {
    let self = this;
    self.$nextTick(function () {
      let normalDemand = self.editShift.config[self.$getUserLevelValue('VALUE_NORMAL')];
      self.normalDemandOfShift.demandId = Number(normalDemand.id);
      self.normalDemandOfShift.config1 = Number(normalDemand.config1);
      self.normalDemandOfShift.config2 = Number(normalDemand.config2);
      self.normalDemandOfShift.originConfig1 = Number(normalDemand.config1);
      self.normalDemandOfShift.originConfig2 = Number(normalDemand.config2);
      self.normalDemandOfShift.level = normalDemand.level;
      self.normalDemandOfShift.checkedUserIds = normalDemand.people.map(function (user) {
        return user.id;
      });
      self.normalDemandOfShift.assignedUsers = normalDemand.people;

      let seniorDemand = self.editShift.config[self.$getUserLevelValue('VALUE_SENIOR')];
      self.seniorDemandOfShift.demandId = Number(seniorDemand.id);
      self.seniorDemandOfShift.config1 = Number(seniorDemand.config1);
      self.seniorDemandOfShift.config2 = Number(seniorDemand.config2);
      self.seniorDemandOfShift.originConfig1 = Number(seniorDemand.config1);
      self.seniorDemandOfShift.originConfig2 = Number(seniorDemand.config2);
      self.seniorDemandOfShift.level = seniorDemand.level;
      self.seniorDemandOfShift.checkedUserIds = seniorDemand.people.map(function (user) {
        return user.id;
      });
      self.seniorDemandOfShift.assignedUsers = seniorDemand.people;

      self.getNormalUsers();
      self.getSeniorlUsers();
    });
  },
}
</script>
