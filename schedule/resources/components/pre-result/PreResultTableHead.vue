<template>
  <thead>
    <tr class="gray-background">
      <td rowspan="3">員工編號</td>
      <td rowspan="3">職級</td>
      <td rowspan="3" style="width: 105px">姓名</td>
      <td rowspan="3">前月排班</td>
      <td
        rowspan="2"
        v-for="(day, d1) in getDays"
        :key="`1${d1}`"
        class="grid-width"
        :class="{todayMark: isToday(day)}"
      >{{day}}</td>
      <td rowspan="2" class="remark">備註</td>
      <td rowspan="2">排班</td>
      <td colspan="4">出勤</td>
      <td colspan="4">不出勤</td>
      <td rowspan="2" style="width: 40px">當月差額</td>
      <td rowspan="2" style="width: 40px">剩餘補休</td>
      <td rowspan="2" style="width: 40px">剩餘年假</td>
    </tr>
    <tr class="gray-background">
      <td>總計</td>
      <td>加班</td>
      <td>減班</td>
      <td>公假</td>
      <td>總計</td>
      <td>例休國</td>
      <td>計薪請假</td>
      <td>扣薪請假</td>
    </tr>
    <tr class="gray-background">
      <td
        v-for="(d, d2) in getDays"
        :key="`2${d2}`"
        class="grid-width"
      >{{ getWeekday(d) }}</td>
      <td></td>
      <td>時</td>
      <td>時</td>
      <td>時</td>
      <td>時</td>
      <td>天</td>
      <td>天</td>
      <td>天</td>
      <td>天</td>
      <td>天</td>
      <td>時</td>
      <td>時</td>
      <td>天</td>
    </tr>
  </thead>
</template>

<script>
import moment from 'moment';
import 'moment/locale/zh-tw';

moment.locale('zh-tw');
export default {
  props: {
    year: {
      type: Number,
      default: 0
    },
    month: {
      type: Number,
      default: 0
    }
  },
  methods: {
    isToday(d) {
      return moment([this.year, this.month-1, d]).isSame(moment(), 'date');
    },
    getWeekday(d) {
      return moment([this.year, this.month-1, d]).format('dd');
    },
  },
  computed: {
    getDays() {
      return moment([this.year, this.month-1, 1]).daysInMonth();
    },
  },
}
</script>

<style scoped>
  .todayMark {
    border-top: 5px solid #37419a;
  }
</style>
