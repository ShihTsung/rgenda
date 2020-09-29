<template>
  <td
    class="grid-width white-background"
    :class="[isPast, whichBorder, shiftColor]"
    @click="edit($event, shiftInfo)"
  >
    <div>
      <div :class="{triangle: triangle}"></div>
      <div class="shift-cell">{{ shiftType }}</div>
      <div
        v-if="adjustmentStr"
        :class="{addWork: adjustmentStr[0] === '+', subWork: adjustmentStr[0] === '-', showAdjustmentRemark: showAdjustmentRemark}"
        :adjustment-remark="adjustmentRemark"
      >{{ adjustmentStr }}</div>

      <div
        v-if="isCheck && Object.keys(checkContent).length && hoverControl"
        class="checkbox"
        :style="{background: shiftInfo.isModified == true ? '#84C0E9' : 'red'}"
      >
        <div v-for="(r, r_index) in checkContent.reason" :key="r_index">
          {{`${r.split('：')[0]}：`}}
          <br />
          {{r.split('：')[1]}}
        </div>
      </div>
      <div
        class="forbidden-mark"
        v-if="isCheck && Object.keys(checkContent).length && (tellCheckMark === 1)"
        @mouseenter="hoverControl = true"
        @mouseleave="hoverControl = false"
        :style="{fill: shiftInfo.isModified == true ? '#84C0E9' : 'red'}"
      >
        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
          <path
            d="M12 0c-6.627 0-12 5.373-12 12s5.373 12 12 12 12-5.373 12-12-5.373-12-12-12zm7 14h-14v-4h14v4z"
          />
        </svg>
      </div>
      <div
        class="alert-mark"
        v-if="isCheck && Object.keys(checkContent).length && (tellCheckMark === 2)"
        @mouseenter="hoverControl = true"
        @mouseleave="hoverControl = false"
        :style="{fill: shiftInfo.isModified == true ? '#84C0E9' : 'red'}"
      >
        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
          <path
            d="M4 22v-20h16v11.543c0 4.107-6 2.457-6 2.457s1.518 6-2.638 6h-7.362zm18-7.614v-14.386h-20v24h10.189c3.163 0 9.811-7.223 9.811-9.614z"
          />
        </svg>
      </div>
    </div>
  </td>
</template>

<script>
import { getShiftClass, getShiftText } from 'src/results/shift-util.js';
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
      default: "",
    },
    triangle: {
      type: Boolean,
      default: false,
    },
  },

  data() {
    return {
      hoverControl: false,
    };
  },

  methods: {
    getShiftClass,
    getShiftText,
    edit(event, shiftInfo) {
      this.$parent.editShift(event, shiftInfo);
    },
  },
  computed: {
    //判斷該班別的樣式
    shiftColor() {
      if (this.isReady) {
        return this.getShiftClass(this.shiftInfo.shift);
      }
      return "";
    },
    shiftType() {
      if (this.isReady) {
        return this.getShiftText(this.shiftInfo.shift)
      }
      return "-";
    },
    tellCheckMark() {
      if (Object.keys(this.checkContent).length) {
        let forbidMark = this.checkContent.reason
          .toString()
          .indexOf("不合法規");
        let alertMark = this.checkContent.reason
          .toString()
          .indexOf("不合排班條件");

        if (forbidMark != -1) {
          return 1;
        } else if (alertMark != -1) {
          return 2;
        }
      }
      return 0;
    },
    showAdjustmentRemark() {
      return this.adjustmentRemark.length !== 0;
    },
  },
};
</script>

<style scoped lang="scss">
$color-dark-blue: #37419a;

td {
  vertical-align: top;
}

td > div {
  position: relative;
}

.shift-cell {
  text-align: center;
  max-width: 45px;
  overflow: hidden;
}

.triangle {
  position: absolute;
  margin: 0;
  top: 0;
  left: 0;
  width: 0;
  height: 0;
  border-style: solid;
  border-width: 11px 11px 0 0;
  border-color: $color-dark-blue transparent transparent transparent;
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

.rs1 {
  box-shadow: inset 0px 0px 0px 2px #58b4ae;
}
.rs2 {
  box-shadow: inset 0px 0px 0px 2px #84b1ed;
}
.rs3 {
  box-shadow: inset 0px 0px 0px 2px #37419a;
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
