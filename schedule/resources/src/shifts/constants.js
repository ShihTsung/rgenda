import { PROMISE_LEAVE_CATEGORY } from '../promise-leave/constants.js';

export const SHIFT_TYPE =  {
  VALUE_DAY_SHIFT: 0, // 白班
  VALUE_NIGHT_SHIFT: 1, // 小夜
  VALUE_GRAVEYARD_SHIFT: 2, // 大夜
  VALUE_OFFICIAL_LEAVE: 3, // 公假
  VALUE_ON_CALL: 4, // on call
  VALUE_PAID_LEAVE: 5, // 有薪假
  VALUE_UNPAID_LEAVE: 6, // 無薪假
  VALUE_ADM_SHIFT: 7, // 行政
};

let workShiftTypeItems = [
  {
    id: SHIFT_TYPE.VALUE_DAY_SHIFT,
    text: "白班",
  },
  {
    id: SHIFT_TYPE.VALUE_NIGHT_SHIFT,
    text: "小夜",
  },
  {
    id: SHIFT_TYPE.VALUE_GRAVEYARD_SHIFT,
    text: "大夜",
  },
  {
    id: SHIFT_TYPE.VALUE_ON_CALL,
    text: "On Call",
  },
  {
    id: SHIFT_TYPE.VALUE_ADM_SHIFT,
    text: "行政",
  },
];

let leaveShiftTypeItems = [
  {
    id: SHIFT_TYPE.VALUE_OFFICIAL_LEAVE,
    text: "公假",
  },
  {
    id: SHIFT_TYPE.VALUE_PAID_LEAVE,
    text: "有薪假",
  },
  {
    id: SHIFT_TYPE.VALUE_UNPAID_LEAVE,
    text: "無薪假",
  },
];

SHIFT_TYPE.install = function (Vue, options) {
  Vue.use(PROMISE_LEAVE_CATEGORY);
  Vue.prototype.$getShiftTypeValue = (key) => {
    return SHIFT_TYPE[key]
  }

  Vue.prototype.$getShiftTypeText = (key) => {
    let obj = this.$getShiftTypeList.find(function (element) {
      return element.id == key;
    });
    if (undefined !== obj) {
      return obj.text;
    }
    return 'NA';
  }

  Vue.prototype.$getShiftTypeList = () => {
    return [...workShiftTypeItems, ...leaveShiftTypeItems];
  }

  Vue.prototype.$getWorkShiftTypeList = () => {
    return workShiftTypeItems;
  }

  /**
   * @typedef {Object} shiftType
   * @property {Number} typeId
   * @property {String} typeText
   * @property {(Number|undefined)} leaveTypeId - return undefined if no match
   * @property {String} leaveTypeText - return empty string if no match
   * @property {Boolean} isLeave
   */

  /**
   * Get shift type and leave type
   * @param {Number} shiftType shift.shift_type
   * @param {String} shiftName shift.name
   * @return {(shiftType|undefined)} shift type and leave type. If no match, then return `undefined`
   */
  //TODO: remove unused method
  Vue.prototype.$getShiftTypeAndLeaveType = (shiftType, shiftName) => {
    let obj = this.$getShiftTypeList.find(function (element) {
      return element.id == shiftType;
    });
    if (undefined === obj) {
      return obj;
    }
    if (this.$isWorkShift(shiftType)) {
      return {
        typeId: obj.id,
        typeText: obj.text,
        leaveTypeId: undefined,
        leaveTypeText: '',
        isLeave: false,
      };
    } else {
      let leaveTypeObj = this.$getPromiseLeaveItemByText(shiftName);
      if (undefined !== obj) {
        return {
          typeId: obj.id,
          typeText: obj.text,
          leaveTypeId: leaveTypeObj.id,
          leaveTypeText: leaveTypeObj.text,
          isLeave: true,
        };
      }
      return {
        typeId: obj.id,
        typeText: obj.text,
        leaveTypeId: undefined,
        leaveTypeText: '',
        isLeave: true,
      };
    }
  }

  Vue.prototype.$isWorkShift = (shiftType) => {
    return workShiftTypeItems.some(function (element) {
      return element.id == shiftType;
    });
  }
}
