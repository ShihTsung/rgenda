export const ADJUSTMENT_TYPE = {
  TYPE_INCREASE_HOURS: 0, // 增加時數
  TYPE_REDUCE_HOURS: 1, // 減少時數
};

ADJUSTMENT_TYPE.install = function (Vue, options) {
  Vue.prototype.$getAdjustmentTypeValue = (key) => {
    return ADJUSTMENT_TYPE[key]
  }
  Vue.prototype.$getAdjustmentTypeText = (key) => {
    let obj = {
      [ADJUSTMENT_TYPE.TYPE_INCREASE_HOURS]: "增加時數",
      [ADJUSTMENT_TYPE.TYPE_REDUCE_HOURS]: "減少時數",
    };
    if (obj.hasOwnProperty(key)) {
      return obj[key];
    }

    return 'NA';
  }
}

export const ADJUSTMENT_ITEM = {
  ITEM_WORK_OVERTIME: 0, // 工作日加班
  ITEM_OFF_DAY_ATTENDANCE: 1, // 休息日出勤
  ITEM_NATIONAL_HOLIDAY_ATTENDANCE: 2, // 國定假日出勤
  ITEM_EMPTY_SHIFT_ATTENDANCE: 3, // 空班出勤
  ITEM_ON_CALL_ATTENDANCE: 4, // On Call 出勤
  ITEM_INSTITUTION_REDUCE_CLASS: 5, // 機構減班
  ITEM_EMPLOYEE_LEAVE: 6, // 員工自假
};

ADJUSTMENT_ITEM.install = function (Vue, options) {
  Vue.prototype.$getAdjustmentItemValue = (key) => {
    return ADJUSTMENT_ITEM[key]
  }
  Vue.prototype.$getAdjustmentItemText = (key) => {
    let obj = {
      [ADJUSTMENT_ITEM.ITEM_WORK_OVERTIME]: "工作日加班",
      [ADJUSTMENT_ITEM.ITEM_OFF_DAY_ATTENDANCE]: "休息日出勤",
      [ADJUSTMENT_ITEM.ITEM_NATIONAL_HOLIDAY_ATTENDANCE]: "國定假日出勤",
      [ADJUSTMENT_ITEM.ITEM_EMPTY_SHIFT_ATTENDANCE]: "空班出勤",
      [ADJUSTMENT_ITEM.ITEM_ON_CALL_ATTENDANCE]: "On Call 出勤",
      [ADJUSTMENT_ITEM.ITEM_INSTITUTION_REDUCE_CLASS]: "機構減班",
      [ADJUSTMENT_ITEM.ITEM_EMPLOYEE_LEAVE]: "員工自假",
    };
    if (obj.hasOwnProperty(key)) {
      return obj[key];
    }

    return 'NA';
  }
}
