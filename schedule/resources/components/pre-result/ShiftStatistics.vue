<template>
  <tr class="white-background">
    <td colspan="4">{{ shiftName }}</td>
    <td class="grid-width" v-for="(ds, d5) in getDays" :key="`5${d5}`">
      <div :class="getDemandClass(d5)">{{ getDemandValue(d5) }}</div>
    </td>
    <td class="gray-background"></td>
    <td colspan="13">
      <div class="mark" :class="rs"></div>
      <input
        type="text"
        class="mark-explanation"
        v-if="isEdit"
        :value="remarkContent"
        @blur="setRemarkContent($event)"
        @keyup.13="$event.target.blur"
      />
      <div style="float: left;" v-if="!isEdit && (remarkContent.length != 0)">{{ remarkContent }}</div>
      <div style="float: left;" v-if="!isEdit && (remarkContent.length == 0)">請填寫標誌說明</div>
    </td>
  </tr>
</template>

<script>
export default {
  props: {
    isReady: {
      type: Boolean,
      default: false,
    },
    isEdit: {
      type: Boolean,
      default: true,
    },
    shiftName: {
      type: String,
      default: "",
    },
    shiftKey: {
      type: String,
      default: "",
    },
    getDays: {
      type: Number,
      default: 30,
    },
    demandList: {
      type: Array,
      default: function () {
        return [];
      },
    },
    rs: {
      type: String,
      default: "",
    },
    remarkContent: {
      type: String,
      default: "",
    },
  },
  methods: {
    getDemandClass(idx) {
      if (this.demandList[idx] && this.demandList[idx][this.shiftKey]) {
        let demand = this.demandList[idx][this.shiftKey];
        if (demand[0] > demand[1]) {
          return "lack";
        } else if (demand[0] < demand[1]) {
          return "enough";
        }
      }
      return "";
    },
    getDemandValue(idx) {
      if (this.demandList[idx] && this.demandList[idx][this.shiftKey]) {
        return this.demandList[idx][this.shiftKey][1];
      }
      return 0;
    },
    setRemarkContent(event) {
      this.$parent.setRemarkContent(event);
    },
  },
};
</script>

<style scoped>
.mark {
  width: 20px;
  height: 20px;
  background: white;
  float: left;
  margin-left: 1rem;
  margin-top: 2px;
  margin-right: 1rem;
}

.mark-explanation {
  border: none;
  float: left;
}

.enough {
  color: red;
}

.lack {
  color: white;
  background: red;
  width: 100%;
}

.rs1 {
  border: 3px solid #58b4ae;
}

.rs2 {
  border: 3px solid #84b1ed;
}

.rs3 {
  border: 3px solid #37419a;
}
</style>
