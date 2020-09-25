export const APPLICATION_STATUS_CONST = {
  TO_BE_CONFIRM: 0,
  REVIEWING: 1,
  REJECT: 2,
  APPROVE: 3,
  FLOW_COMPLETE: 9999,
};

const statusFlow = {
  [APPLICATION_STATUS_CONST.TO_BE_CONFIRM]: {
    next: APPLICATION_STATUS_CONST.REVIEWING,
  },
  [APPLICATION_STATUS_CONST.REVIEWING]: {
    next: APPLICATION_STATUS_CONST.APPROVE,
    reject: APPLICATION_STATUS_CONST.REJECT,
  },
  [APPLICATION_STATUS_CONST.REJECT]: {
    next: APPLICATION_STATUS_CONST.FLOW_COMPLETE,
  },
  [APPLICATION_STATUS_CONST.APPROVE]: {
    next: APPLICATION_STATUS_CONST.FLOW_COMPLETE,
  },
}

APPLICATION_STATUS_CONST.install = function (Vue, options) {
  Vue.prototype.$getApplicationStatusString = (key) => {
    const obj = {
      [APPLICATION_STATUS_CONST.TO_BE_CONFIRM]: '待確認',
      [APPLICATION_STATUS_CONST.REVIEWING]: '審核中',
      [APPLICATION_STATUS_CONST.REJECT]: '未通過',
      [APPLICATION_STATUS_CONST.APPROVE]: '已生效',
    };
    return obj.hasOwnProperty(key) ? obj[key] : 'N/A';
  }

  Vue.prototype.$getNextStep = (key) => {
    return statusFlow.hasOwnProperty(key) ? statusFlow[key] : null;
  }
}
