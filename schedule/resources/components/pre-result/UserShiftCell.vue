<template>
  <td class="grid-width white-background" :class="isPast" @click="edit($event, shift)">
    <div v-if="!isReady">-</div>
    <div v-if="shift" :class="shiftColor(shift.shift_type)">{{ shift.shift_type }}</div>
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
    shift: {
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
    shiftColor(type) {
      switch (type) {
        case 'A':
          return 'dayShift';
        case 'E':
          return 'nightShift';
        case 'N':
          return 'graveyardShift';
        case '公':
          return 'rest';
        case '例':
          return 'rest';
        case '休':
          return 'rest';
        case '國':
          return 'rest';
        case 'On':
          return 'onCall';
        case 'B':
          return 'adminis';
        case '補':
          return 'restR';
        case '特':
          return 'restR';
        case '事':
          return 'restR';
        default:
          return '';
      }
    },
  },
};
</script>

<style>
</style>
