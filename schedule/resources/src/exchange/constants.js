export const APPLICATION_STATUS_CONST = {
  TO_BE_CONFIRM: 0,
  REVIEWING: 1,
  REJECT_TO_BE_FILE: 2,
  APPROVE_TO_BE_FILE: 3,
  REJECT_FILED: 4,
  APPROVE_FILED: 5,
};

APPLICATION_STATUS_CONST.install = function (Vue, options) {
  Vue.prototype.$getApplicationStatusString = (key) => {
    const obj = {
      [APPLICATION_STATUS_CONST.TO_BE_CONFIRM]: '待確認',
      [APPLICATION_STATUS_CONST.REVIEWING]: '審核中',
      [APPLICATION_STATUS_CONST.REJECT_TO_BE_FILE]: '拒絕-待歸檔',
      [APPLICATION_STATUS_CONST.APPROVE_TO_BE_FILE]: '核准-待歸檔',
      [APPLICATION_STATUS_CONST.REJECT_FILED]: '拒絕-已歸檔',
      [APPLICATION_STATUS_CONST.APPROVE_FILED]: '核准-已歸檔',
    };
    return obj.hasOwnProperty(key) ? obj[key] : 'N/A';
  }
}
