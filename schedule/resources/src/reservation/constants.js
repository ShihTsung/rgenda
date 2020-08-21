export const TIME_ADJUSTMENT_TYPE = {
  TYPE_INCREASE_HOURS: 0, // 增加時數
  TYPE_REDUCE_HOURS: 1, // 減少時數
};
let timeAdjustmentTypeTextList = [
  { id: TIME_ADJUSTMENT_TYPE.TYPE_INCREASE_HOURS, text: "增加時數" },
  { id: TIME_ADJUSTMENT_TYPE.TYPE_REDUCE_HOURS, text: "減少時數" },
];
TIME_ADJUSTMENT_TYPE.install = function (Vue, options) {
  Vue.prototype.$getTimeAdjustmentTypeValue = (key) => {
    return TIME_ADJUSTMENT_TYPE[key]
  }

  Vue.prototype.$getTimeAdjustmentTypeText = (key) => {
    let obj = timeAdjustmentTypeTextList.find(function (item) {
      return item.id === key;
    });
    if (undefined === obj) {
      return 'NA';
    } else {
      return obj.text;
    }
  }

  Vue.prototype.$getAllTimeAdjustmentTypeText = (key) => {
    return timeAdjustmentTypeTextList;
  }
}

export const TIME_ADJUSTMENT_ITEM = {
  ITEM_WORK_OVERTIME: 0, // 工作日加班
  ITEM_OFF_DAY_ATTENDANCE: 1, // 休息日出勤
  ITEM_NATIONAL_HOLIDAY_ATTENDANCE: 2, // 國定假日出勤
  ITEM_EMPTY_SHIFT_ATTENDANCE: 3, // 空班出勤
  ITEM_ON_CALL_ATTENDANCE: 4, // On Call 出勤
  ITEM_INSTITUTION_REDUCE_CLASS: 5, // 機構減班
  ITEM_EMPLOYEE_LEAVE: 6, // 員工自假
};

let timeAdjustmentItemTextList = {
  [TIME_ADJUSTMENT_TYPE.TYPE_INCREASE_HOURS]: [
    { id: TIME_ADJUSTMENT_ITEM.ITEM_WORK_OVERTIME, text: "工作日加班" },
    { id: TIME_ADJUSTMENT_ITEM.ITEM_OFF_DAY_ATTENDANCE, text: "休息日出勤" },
    { id: TIME_ADJUSTMENT_ITEM.ITEM_NATIONAL_HOLIDAY_ATTENDANCE, text: "國定假日出勤" },
    { id: TIME_ADJUSTMENT_ITEM.ITEM_EMPTY_SHIFT_ATTENDANCE, text: "空班出勤" },
    { id: TIME_ADJUSTMENT_ITEM.ITEM_ON_CALL_ATTENDANCE, text: "On Call 出勤" },
  ],
  [TIME_ADJUSTMENT_TYPE.TYPE_REDUCE_HOURS]: [
    { id: TIME_ADJUSTMENT_ITEM.ITEM_INSTITUTION_REDUCE_CLASS, text: "機構減班" },
    { id: TIME_ADJUSTMENT_ITEM.ITEM_EMPLOYEE_LEAVE, text: "員工自假" },
  ]
};
TIME_ADJUSTMENT_ITEM.install = function (Vue, options) {
  Vue.prototype.$getTimeAdjustmentItemValue = (key) => {
    return TIME_ADJUSTMENT_ITEM[key]
  }

  Vue.prototype.$getTimeAdjustmentItemText = (key) => {
    let obj = timeAdjustmentItemTextList.find(function (item) {
      return item.id === key;
    });
    if (undefined === obj) {
      return 'NA';
    } else {
      return obj.text;
    }
  }

  Vue.prototype.$getTimeAdjustmentItemsByTypeKey = (typeKey) => {
    if (!timeAdjustmentItemTextList.hasOwnProperty(typeKey)) {
      return [];
    }

    return timeAdjustmentItemTextList[typeKey];
  }
}
