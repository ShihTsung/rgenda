<template>
  <td class="grid-width white-background" :class="[isPast, whichBorder]" @click="edit($event, shiftInfo)">
    <div :class="shiftColor(shiftInfo)">{{ shiftType(shiftInfo) }}</div>
    <div
      v-if="adjustmentStr"
      :class="adjustmentStr[0] == '+' ? 'addWork' : 'subWork'"
    >{{ adjustmentStr }}</div>
  </td>
</template>

<script>
export default {
  props: {
    isReady: {
      type: Boolean,
      default: false,
    },
    isPast: {
      type: String,
      default: '',
    },
    whichBorder: {
      type: String,
      default: '',
    },
    shiftInfo: {
      type: Object,
      default: function () {
        return {};
      },
    },
    adjustmentStr: {
      type: String,
      default: '',
    },
  },
  methods: {
    edit(event, shiftInfo) {
      this.$parent.editShift(event, shiftInfo);
    },
    //判斷該班別的樣式
    shiftColor(shiftInfo) {
      if (shiftInfo.shift) {
        switch (shiftInfo.shift.shift_type) {
          case 0:
            return 'dayShift';
          case 1:
            return 'nightShift';
          case 2:
            return 'graveyardShift';
          case 7:
            return 'adminis';
          case 3:
            return 'rest';
          case 4:
            return 'onCall';
          case 5:
            switch (shiftInfo.shift.name) {
              case '休息':
              case '例假':
              case '國定假日':
              case '公假':
                return 'rest';
              case '補休':
              case '特休':
                return 'restR';
            }
            break;
          case 6:
            if (shiftInfo.shift.name === '事假') {
              return 'restR';
            }
            break;
        }
      }
      return '';
    },
    shiftType(shiftInfo) {
      if (this.isReady && shiftInfo.shift) {
        switch (shiftInfo.shift.shift_type) {
          case 0:
          case 1:
          case 2:
          case 7:
            return shiftInfo.shift.code;
          case 3:
            return '公';
          case 4:
            return shiftInfo.shift.code === '' ? 'On' : shiftInfo.shift.code;
          case 5:
            switch (shiftInfo.shift.name) {
              case '休息':
                return '休';
              case '例假':
                return '例';
              case '補休':
                return '補';
              case '特休':
                return '特';
              case '空班':
                return '空';
              case '婚假':
                return '婚';
              case '喪假':
                return '喪';
              case '產假':
                return '產';
              case '生理假':
                return '生';
              case '國定假日':
                return '國';
            }
            break;
          case 6:
            switch (shiftInfo.shift.name) {
              case '無薪病假':
                return '病';
              case '事假':
                return '事';
              case '家庭照顧假':
                return '家';
            }
            break;
        }
      }
      return '-';
    },
  },
};
</script>

<style>
</style>
