<template>
  <div style="position:relative">
    <input class="form-control" type="text"
    v-model="inputValue"
    placeholder="輸入以查詢人員"
    @input="updateValue()"
    @keydown.enter='enter' @keydown.down='down' @keydown.up='up'>
    <div :class="{ 'dropdown-menu': true, 'show': openSuggestion }" style="width:100%">
      <button v-for="(suggestion, index) in matches"
      :key="'account_' + index"
      :class="{ 'dropdown-item': true, 'active': isActive(index) }"
      @click="suggestionClick(index)">
        {{ suggestion[labelKey] }}
      </button>
    </div>
  </div>
</template>
<script>
export default {
  props: ['value', 'labelKey', 'itemList'],
  data() {
    return {
      inputValue: '',
      current: 0,
      open: false,
    }
  },
  methods: {
    updateValue() {
      if (this.open === false) {
        this.open = true;
        this.current = 0;
      }
    },
    enter() {
      this.suggestionClick(this.current);
    },
    up() {
      if (this.current > 0) {
        this.current--;
      }
    },
    down() {
      if (this.current < this.matches.length -1) {
        this.current++;
      }
    },
    isActive(index) {
      return index === this.current;
    },
    suggestionClick(index) {
      const value = {
        id: this.matches[index].id,
        name: this.matches[index][this.labelKey]
      };
      this.$emit('input', value);
      this.open = false;
    },
  },
  computed: {
    matches() {
      this.current = 0;
      if (this.inputValue !== '') {
        return this.itemList.filter(item => item[this.labelKey].indexOf(this.inputValue) >= 0);
      }
      return [];
    },
    openSuggestion() {
      return this.matches.length !== 0 && this.open === true;
    },
  },
  mounted() {
    this.inputValue = this.value.name || '';
  },
  watch: {
    value(newVal) {
      if (newVal.name) {
        this.inputValue = newVal.name;
      } else {
        this.inputValue = '';
      }
    },
  },
}
</script>
<style scoped>
.dropdown-menu {
  max-height: 20vh;
  overflow-y: auto;
}
</style>
