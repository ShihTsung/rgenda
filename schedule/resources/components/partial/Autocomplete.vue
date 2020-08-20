<template>
  <div style="position:relative">
    <input class="form-control" type="text" :value="value.text"
      :placeholder="placeholder"
      @input="updateValue($event.target.value)"
      @keydown.enter='enter' @keydown.down='down' @keydown.up='up'>
    <div :class="{'dropdown-menu': true, 'show': openSuggestion}" style="width:100%">
      <a v-for="(suggestion, index) in matches"
        :key="'account_' + index"
        :class="{'dropdown-item': true, 'active': isActive(index)}"
        @click="suggestionClick(index)">{{ suggestion.text }}</a>
    </div>
  </div>
</template>

<script>
import _ from "lodash";

export default {
  props: {
    value: {
      type: Object,
      default: {},
    },
    suggestions: {
      type: Array,
      default: [],
    },
    placeholder: {
      type: String,
      default: '輸入姓名以選取人員'
    }
  },
  data() {
    return {
      open: false,
      current: 0
    }
  },
  computed: {
    // Filtering the suggestion based on the input
    matches() {
      let self = this;

      self.current = 0;
      if (Object.keys(self.value).length > 0 && self.value.text !== '') {
        return _.filter(self.suggestions, function (obj) {
          return obj.text.toLowerCase().includes(self.value.text.toLowerCase());
        })
      } else {
        return [];
      }
    },
    openSuggestion() {
      return this.matches.length !== 0 &&
        this.open === true
    }
  },
  methods: {
    updateValue(value) {
      if (this.open === false) {
        this.open = true
        this.current = 0
      }
      this.$emit('input', {
        id: 0,
        text: value,
      });
    },
    enter() {
      this.$emit('input', this.matches[this.current])
      this.open = false
    },
    up() {
      if (this.current > 0) {
        this.current--
      }
    },
    down() {
      if (this.current < this.matches.length - 1) {
        this.current++
      }
    },
    isActive(index) {
      return index === this.current
    },
    suggestionClick(index) {
      this.$emit('input', this.matches[index])
      this.open = false
    }
  }
}
</script>
