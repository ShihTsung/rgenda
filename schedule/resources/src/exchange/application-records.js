import Vue from "vue";
import ApplicationRecords from "components/exchange/ApplicationRecords.vue";
import VueGoodTablePlugin from "vue-good-table";
Vue.use(VueGoodTablePlugin);
import "vue-good-table/dist/vue-good-table.css";
import HttpClient from "common/http";
Vue.use(HttpClient);
import { APPLICATION_STATUS_CONST } from "./constants.js";
Vue.use(APPLICATION_STATUS_CONST);
import { SHIFT_TYPE } from "../shifts/constants.js";
Vue.use(SHIFT_TYPE);

new Vue({
  el: "#app",
  components: {
    ApplicationRecords
  }
});
