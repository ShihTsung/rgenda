<template>
  <td
    class="grid-width white-background"
    :class="[isPast, whichBorder]"
    @click="edit($event, shiftInfo)"
    style="position: relative;"
  >
    <div v-if="isCheck && Object.keys(checkContent).length && hoverControl" class="checkbox" :style="{background: isChangeShift}">
      <div v-for="(r, r_index) in checkContent.reason" :key="r_index">
        {{`${r.split('：')[0]}：`}}
        <br/>
        {{r.split('：')[1]}}
      </div>
    </div>
    <div
      class="forbidden-mark"
      v-if="isCheck && Object.keys(checkContent).length && (tellCheckMark(checkContent) === 1)"
      @mouseenter="hoverControl = true" @mouseleave="hoverControl = false"
      :style="{fill: isChangeShift}"
    >
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
        <path
          d="M12 0c-6.627 0-12 5.373-12 12s5.373 12 12 12 12-5.373 12-12-5.373-12-12-12zm7 14h-14v-4h14v4z"
        />
      </svg>
    </div>
    <div
      class="alert-mark"
      v-if="isCheck && Object.keys(checkContent).length && (tellCheckMark(checkContent) === 2)"
      @mouseenter="hoverControl = true" @mouseleave="hoverControl = false"
      :style="{fill: isChangeShift}"
    >
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
        <path
          d="M4 22v-20h16v11.543c0 4.107-6 2.457-6 2.457s1.518 6-2.638 6h-7.362zm18-7.614v-14.386h-20v24h10.189c3.163 0 9.811-7.223 9.811-9.614z"
        />
      </svg>
    </div>
    <div>
      <div :class="{triangle: triangle}"></div>
      <div class="shift-cell" :class="shiftColor">{{ shiftType }}</div>
      <div
        v-if="adjustmentStr"
        :class="{addWork: adjustmentStr[0] === '+', subWork: adjustmentStr[0] === '-', showAdjustmentRemark: showAdjustmentRemark}"
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
      default: "",
    },
    whichBorder: {
      type: String,
      default: "",
    },
    shiftInfo: {
      type: Object,
      default: function () {
        return {};
      },
    },
    adjustmentStr: {
      type: String,
      default: "",
    },
    checkContent: {
      type: Object,
      default: function () {
        return {};
      },
    },
    isCheck: {
      type: Boolean,
      default: false,
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

  data() {
    return {
      hoverControl: false,
      isChangeShift: '',//檢核框框顏色控制
    };
  },

  methods: {
    edit(event, shiftInfo) {
      this.$parent.editShift(event, shiftInfo);
      this.isChangeShift = '#84C0E9';
    },
  },
  computed: {
    //判斷該班別的樣式
    shiftColor() {
      if (this.shiftInfo.shift) {
        switch (this.shiftInfo.shift.shift_type) {
          case 0:
            return "dayShift";
          case 1:
            return "nightShift";
          case 2:
            return "graveyardShift";
          case 7:
            return "adminis";
          case 3:
            return "rest";
          case 4:
            return "onCall";
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
      return "";
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
            return "公";
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
      return "-";
    },
    tellCheckMark(item) {
      if (Object.keys(item).length) {
        let forbidMark = item.reason.toString().indexOf("不合法規");
        let alertMark = item.reason.toString().indexOf("不合排班條件");

        if (forbidMark != -1) {
          return 1;
        } else if (alertMark != -1) {
          return 2;
        }
      }
    },
    showAdjustmentRemark() {
      return this.adjustmentRemark.length !== 0;
    }
  },
};
</script>

<style scoped lang="scss">
$color-dark-blue: #37419a;

td > div {
  position: relative;
}

.shift-cell {
  max-width: 45px;
  overflow: hidden;
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

.showAdjustmentRemark[adjustment-remark]:hover::after {
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
  white-space: normal;
  width: max-content;
  box-shadow: 0 0 2px;
}
.checkbox {
  position: absolute;
  background: red;
  width: 160px;
  white-space: normal;
  color: white;
  z-index: 1;
  padding: 8px 3px;
  text-align: left;
}
.grid-width {
  height: 40px;
}
.hoverEvent {
  &:hover {
    cursor: pointer;
    background: rgba(185, 184, 184, 0.26) !important;
  }
}
.forbidden-mark {
  fill: red;
  opacity: 0.5;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}
.alert-mark {
  fill: red;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}
</style>
