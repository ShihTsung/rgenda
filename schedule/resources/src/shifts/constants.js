export const SHIFT_TYPE =  {
  VALUE_DAY_SHIFT: 0, // 白班
  VALUE_NIGHT_SHIFT: 1, // 小夜
  VALUE_GRAVEYARD_SHIFT: 2, // 大夜
  VALUE_ON_CALL: 4, // on call
  VALUE_ADM_SHIFT: 7, // 行政
};

let shiftTypeList = [
  {
    id: SHIFT_TYPE.VALUE_DAY_SHIFT,
    text: "白班",
  },
  {
    id: SHIFT_TYPE.VALUE_NIGHT_SHIFT,
    text: "小夜",
  },
  {
    id: SHIFT_TYPE.VALUE_GRAVEYARD_SHIFT,
    text: "大夜",
  },
  {
    id: SHIFT_TYPE.VALUE_ON_CALL,
    text: "On Call",
  },
  {
    id: SHIFT_TYPE.VALUE_ADM_SHIFT,
    text: "行政",
  },
]
SHIFT_TYPE.install = function (Vue, options) {
  Vue.prototype.$getShiftTypeValue = (key) => {
    return SHIFT_TYPE[key]
  }

  Vue.prototype.$getShiftTypeText = (key) => {
    let obj = shiftTypeList.find(function (element) {
      return element.id == key;
    });
    if (undefined !== obj) {
      return obj.text;
    }
    return 'NA';
  }

  Vue.prototype.$getShiftTypeList = () => {
    return shiftTypeList;
  }
}
