export const PROMISE_LEAVE_CATEGORY = {
  UNPAID_LEAVE: 0,
  PAID_LEAVE: 1,
};
let promiseLeaveCategoryTextList = [{
    id: PROMISE_LEAVE_CATEGORY.UNPAID_LEAVE,
    text: "無薪假"
  },
  {
    id: PROMISE_LEAVE_CATEGORY.PAID_LEAVE,
    text: "有薪假"
  },
];
PROMISE_LEAVE_CATEGORY.install = function (Vue, options) {
  Vue.prototype.$getPromiseLeaveCategoryValue = (key) => {
    return PROMISE_LEAVE_CATEGORY[key]
  }
  Vue.prototype.$getAllPromiseLeaveCategoryText = (key) => {
    return promiseLeaveCategoryTextList;
  }
}

export const PROMISE_LEAVE_ITEM = {
  ITEM_PERSONAL_LEAVE: 0, // 工作日加班
  ITEM_FAMILY_CARE_LEAVE: 1, // 休息日出勤
  ITEM_UNPAID_SICK_LEAVE: 2, // 國定假日出勤
  ITEM_OFFICIAL_LEAVE: 3, // 空班出勤
  ITEM_ON_CALL_ATTENDANCE: 4, // On Call 出勤
  ITEM_INSTITUTION_REDUCE_CLASS: 5, // 機構減班
  ITEM_EMPLOYEE_LEAVE: 6, // 員工自假
};

let promiseLeaveItemTextList = {
  [PROMISE_LEAVE_CATEGORY.UNPAID_LEAVE]: [{
      id: PROMISE_LEAVE_ITEM.ITEM_PERSONAL_LEAVE,
      text: "事假"
    },
    {
      id: PROMISE_LEAVE_ITEM.ITEM_FAMILY_CARE_LEAVE,
      text: "家庭照顧假"
    },
    {
      id: PROMISE_LEAVE_ITEM.ITEM_UNPAID_SICK_LEAVE,
      text: "無薪病假"
    },
  ],
  [PROMISE_LEAVE_CATEGORY.PAID_LEAVE]: [{
      id: PROMISE_LEAVE_ITEM.ITEM_OFFICIAL_LEAVE,
      text: "公假"
    },
    {
      id: PROMISE_LEAVE_ITEM.ITEM_MATERNITY_LEAVE,
      text: "產假"
    },
    {
      id: PROMISE_LEAVE_ITEM.ITEM_OFFICIAL_HOLIDAY,
      text: "例/休"
    },
    {
      id: PROMISE_LEAVE_ITEM.ITEM_MENSTRUAL_LEAVE,
      text: "生理假"
    },
    {
      id: PROMISE_LEAVE_ITEM.ITEM_ANNUAL_LEAVE,
      text: "特休"
    },
    {
      id: PROMISE_LEAVE_ITEM.ITEM_COMPENSATORY_LEAVE,
      text: "補休"
    },
    {
      id: PROMISE_LEAVE_ITEM.ITEM_MARRIAGE_LEAVE,
      text: "婚假"
    },
    {
      id: PROMISE_LEAVE_ITEM.ITEM_PAID_SICK_LEAVE,
      text: "計薪病假"
    },
    {
      id: PROMISE_LEAVE_ITEM.ITEM_BEREAVEMENT_LEAVE,
      text: "喪假"
    },
    {
      id: PROMISE_LEAVE_ITEM.ITEM_TOCOLYSIS_LEAVE,
      text: "安胎休養假"
    },
    {
      id: PROMISE_LEAVE_ITEM.ITEM_PREGNANCY_CHECKUP,
      text: "產檢假"
    },
    {
      id: PROMISE_LEAVE_ITEM.ITEM_PARENTAL_LEAVE,
      text: "陪產假"
    },
  ]
};
PROMISE_LEAVE_ITEM.install = function (Vue, options) {
  Vue.prototype.$getPromiseLeaveItemValue = (key) => {
    return PROMISE_LEAVE_ITEM[key]
  }

  Vue.prototype.$getPromiseLeaveItemText = (categoryKey, key) => {
    if (!promiseLeaveItemTextList.hasOwnProperty(categoryKey)) {
      return 'NA';
    }
    let obj = promiseLeaveItemTextList[categoryKey].find(function (item) {
      return item.id === key;
    });
    if (undefined === obj) {
      return 'NA';
    } else {
      return obj.text;
    }
  }

  Vue.prototype.$getPromiseLeaveItemsByCategoryKey = (categoryKey) => {
    if (!promiseLeaveItemTextList.hasOwnProperty(categoryKey)) {
      return [];
    }

    return promiseLeaveItemTextList[categoryKey];
  }
}
