export const DEPARTMENT_CONST = {
  RESET_TYPE: {
    PER_YEAR: 0,
    PER_MONTH: 1,
  },
  START_OF_WEEK_TYPE: {
    SUNDAY: 0,
    MONDAY: 1,
  },
  LAW_RULE_TYPE: {
    NORMAL: 0,
    TWO_WEEK: 1,
    FOUR_WEEK: 2,
    EIGHT_WEEK: 3,
  },
  OVERTIME_RULE_TYPE: {
    ONE_MONTH: 0,
    THREE_MONTH: 1,
  },
  SCHEDULE_RULE_TYPE: {
    ONE_WEEK: 0,
    ONE_MONTH: 1,
    THREE_MONTH: 2,
  },
};

DEPARTMENT_CONST.install = function (Vue, options) {
  Vue.prototype.$getResetTypeString = (key) => {
    const obj = {
      [DEPARTMENT_CONST.RESET_TYPE.PER_YEAR]: '每年(1日)',
      [DEPARTMENT_CONST.RESET_TYPE.PER_MONTH]: '每月(1日)',
    };
    return obj.hasOwnProperty(key) ? obj[key] : 'N/A';
  }

  Vue.prototype.$getStartOfWeekString = (key) => {
    const obj = {
      [DEPARTMENT_CONST.START_OF_WEEK_TYPE.SUNDAY]: '週日',
      [DEPARTMENT_CONST.START_OF_WEEK_TYPE.MONDAY]: '週一',
    };
    return obj.hasOwnProperty(key) ? obj[key] : 'N/A';
  }

  Vue.prototype.$getLawRuleString = (key) => {
    const obj = {
      [DEPARTMENT_CONST.LAW_RULE_TYPE.NORMAL]: '一般工時，7休2',
      [DEPARTMENT_CONST.LAW_RULE_TYPE.TWO_WEEK]: '雙週變形工時，14休4',
      [DEPARTMENT_CONST.LAW_RULE_TYPE.FOUR_WEEK]: '四週變形工時，28休8',
      [DEPARTMENT_CONST.LAW_RULE_TYPE.EIGHT_WEEK]: '八週變形工時，56休16',
    };
    return obj.hasOwnProperty(key) ? obj[key] : 'N/A';
  }

  Vue.prototype.$getOvertimeRuleString = (key) => {
    const obj = {
      [DEPARTMENT_CONST.OVERTIME_RULE_TYPE.ONE_MONTH]: '單月46小時',
      [DEPARTMENT_CONST.OVERTIME_RULE_TYPE.THREE_MONTH]: '三個月138小時',
    };
    return obj.hasOwnProperty(key) ? obj[key] : 'N/A';
  }

  Vue.prototype.$getScheduleRuleString = (key) => {
    const obj = {
      [DEPARTMENT_CONST.SCHEDULE_RULE_TYPE.ONE_WEEK]: '單週同班種',
      [DEPARTMENT_CONST.SCHEDULE_RULE_TYPE.ONE_MONTH]: '單月同班種',
      [DEPARTMENT_CONST.SCHEDULE_RULE_TYPE.THREE_MONTH]: '三月同班種',
    };
    return obj.hasOwnProperty(key) ? obj[key] : 'N/A';
  }
}
