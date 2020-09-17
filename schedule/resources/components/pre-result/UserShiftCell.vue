<template>
  <td
    class="grid-width white-background"
    :class="[isPast, whichBorder]"
    @click="edit($event, shiftInfo)"
  >
    <div>
      <div :class="{triangle: triangle}"></div>
      <div :class="shiftColor">{{ shiftType }}</div>
      <div
        v-if="adjustmentStr"
        :class="adjustmentStr[0] == '+' ? 'addWork' : 'subWork'"
        :adjustment-remark="adjustmentRemark"
      >{{ adjustmentStr }}</div>
    </div>
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
    adjustmentRemark: {
      type: String,
      default: '',
    },
    triangle: {
      type: Boolean,
      default: false,
    },
  },
  methods: {
    edit(event, shiftInfo) {
      this.$parent.editShift(event, shiftInfo);
    },
  },
  computed: {
    //判斷該班別的樣式
    shiftColor() {
      if (this.shiftInfo.shift) {
        switch (this.shiftInfo.shift.shift_type) {
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
            switch (this.shiftInfo.shift.name) {
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
            if (this.shiftInfo.shift.name === '事假') {
              return 'restR';
            }
            break;
        }
      }
      return '';
    },
    shiftType() {
      if (this.isReady && this.shiftInfo.shift) {
        switch (this.shiftInfo.shift.shift_type) {
          case 0:
          case 1:
          case 2:
          case 7:
            return this.shiftInfo.shift.code;
          case 3:
            return '公';
          case 4:
            return this.shiftInfo.shift.code === '' ? 'On' : this.shiftInfo.shift.code;
          case 5:
            switch (this.shiftInfo.shift.name) {
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
            switch (this.shiftInfo.shift.name) {
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

<style scoped lang="scss">
$color-dark-blue: #37419a;

td div {
  position: relative;
}

.triangle {
  width: 30px;
  height: 30px;
  clip-path: polygon(0 0, 0 50%, 50% 0);
  background: $color-dark-blue;
  position: absolute;
  margin: 0;
  top: 0;
  left: 0;
}
.addWork[adjustment-remark]:hover::after {
  content: attr(adjustment-remark);
  position: absolute;
  left: 30px;
  top: 20px;
  z-index: 5;
  padding: 1px 3px;
  color: $color-dark-blue;
  border-color: $color-dark-blue;
  background-color: white;
  border-width: 1px;
  border-style: solid;
  border-radius: 5px;
  max-width: 200px;
}
</style>
