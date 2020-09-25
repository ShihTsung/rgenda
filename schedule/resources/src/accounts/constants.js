export const USER_TYPE = {
  VALUE_NORMAL: 0, // 正職
  VALUE_SENIOR: 1, // 資深正職
  VALUE_ADMINISTRATION: 2, // 行政職
  VALUE_NEW_RECRUITS: 3, // 新進人員
  VALUE_PART_TIME: 4, // 兼職人員
  VALUE_INTERN: 5, // 實習生
};

USER_TYPE.install = function (Vue, options) {
  Vue.prototype.$getUserTypeValue = (key) => {
    return USER_TYPE[key]
  }

  Vue.prototype.$getUserTypeString = (key) => {
    let obj = {
      [USER_TYPE.VALUE_NORMAL]: "正職",
      [USER_TYPE.VALUE_SENIOR]: "資深正職",
      [USER_TYPE.VALUE_ADMINISTRATION]: "行政職",
      [USER_TYPE.VALUE_NEW_RECRUITS]: "新進人員",
      [USER_TYPE.VALUE_PART_TIME]: "兼職人員",
      [USER_TYPE.VALUE_INTERN]: "實習生",
    };
    if (obj.hasOwnProperty(key)) {
      return obj[key];
    }

    return 'NA';
  }
}
