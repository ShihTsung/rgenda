import _ from 'lodash';

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
  ITEM_PERSONAL_LEAVE: 0, // 事假
  ITEM_FAMILY_CARE_LEAVE: 1, // 家庭照顧假
  ITEM_UNPAID_SICK_LEAVE: 2, // 無薪病假
  ITEM_OFFICIAL_LEAVE: 3, // 公假
  ITEM_MATERNITY_LEAVE: 4, // 產假
  ITEM_OFFICIAL_HOLIDAY: 5, // 例/休
  ITEM_MENSTRUAL_LEAVE: 6, // 生理假
  ITEM_ANNUAL_LEAVE: 7, // 特休
  ITEM_COMPENSATORY_LEAVE: 8, // 補休
  ITEM_MARRIAGE_LEAVE: 9, // 婚假
  ITEM_PAID_SICK_LEAVE: 10, // 計薪病假
  ITEM_BEREAVEMENT_LEAVE: 11, // 喪假
  ITEM_TOCOLYSIS_LEAVE: 12, // 安胎休養假
  ITEM_PREGNANCY_CHECKUP: 13, // 產檢假
  ITEM_PARENTAL_LEAVE: 14, // 陪產假
};
let groupedPromiseLeaveItemTextList = {
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
let promiseLeaveItems = [...groupedPromiseLeaveItemTextList[PROMISE_LEAVE_CATEGORY.UNPAID_LEAVE], ...groupedPromiseLeaveItemTextList[PROMISE_LEAVE_CATEGORY.PAID_LEAVE]];
PROMISE_LEAVE_ITEM.install = function (Vue, options) {
  Vue.prototype.$getPromiseLeaveItemValue = (key) => {
    return PROMISE_LEAVE_ITEM[key]
  }

  Vue.prototype.$getPromiseLeaveItemText = (key) => {
    let obj = _.find(promiseLeaveItems, function (element) {
      return element.id == key;
    });
    if (undefined !== obj) {
      return obj.text;
    }
    return 'NA';
  }

  Vue.prototype.$getPromiseLeaveItemsByCategoryKey = (categoryKey) => {
    if (!groupedPromiseLeaveItemTextList.hasOwnProperty(categoryKey)) {
      return [];
    }

    return groupedPromiseLeaveItemTextList[categoryKey];
  }
}
