export const nl2br = (str, isXhtml) => {
  if (typeof str === 'undefined' || str === null) {
    return '';
  }
  var breakTag = (isXhtml || typeof isXhtml === 'undefined') ? '<br />' : '<br>';
  return (str + '').replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, '$1' + breakTag + '$2');
};

export const size = (value) => {
  if (!value) {
    return 0;
  }
  let s = value / (1024 * 1024);
  if (parseInt(s, 10) > 0) {
    return s.toFixed(1) + 'MB';
  } else {
    return (value / 1024).toFixed(1) + 'KB'
  }
};

export const httpRep = {
  messageJoin: arrObj => {
    let msgString = '';
    for (var prop in arrObj) {
      if (arrObj.hasOwnProperty(prop)) {
        let msg = arrObj[prop];
        let msgArr = msg || msg.join(',');
        msgString += `<p>${msgArr}</p>`;
      }
    }
    return msgString;
  }
};

export const checkEmpty = (str) => {
  if (str == null || str == undefined || str.length == 0) {
    return false;
  }

  return true;
};

export const formatMoney = function (money) {
  if (!isNaN(money)) {
    return Math.round(money).toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,")
  } else {
    return money;
  }
};
