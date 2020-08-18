export const DEMAND_USER_LEVEL =  {
  VALUE_NORMAL: 1, // 正職
  VALUE_SENIOR: 2, // 資深正職
};

DEMAND_USER_LEVEL.install = function (Vue, options) {
  Vue.prototype.$getUserLevelValue = (key) => {
    return DEMAND_USER_LEVEL[key]
  }
}
