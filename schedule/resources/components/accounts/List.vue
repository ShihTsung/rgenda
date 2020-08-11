<template>
  <div>
    <!-- <vue-good-table
      :columns="columns"
      :rows="rows"
      :search-options="{
        enabled: true,
      }">
      <template slot="table-row" slot-scope="props">
        <template v-if="props.column.field == 'functions'">
          <a href="/accounts/update/">
            <div class="btn icon-bts"><i class="fas fa-edit"></i></div>
          </a>
          <button class="btn icon-bts" type="button" data-toggle="modal" data-target="#modal-delete" value=""><i class="fa fa-trash-alt"></i></button>
        </template>
      </template>
    </vue-good-table> -->
  </div>
</template>

<script>
import popup from 'common/popup';
import {
  httpRep
} from 'common/helpers';
import 'vue-good-table/dist/vue-good-table.css'
import { VueGoodTable } from 'vue-good-table';

export default {
  components: {
    VueGoodTable,
  },
  props: {
    role: {
      type: String,
      default: '',
    },
    isSuperuser: {
      type: Number,
      default: 0,
    },
  },
  data() {
    return {
      // columns: [
      //   {
      //     label: '部門',
      //     field: 'department',
      //   },
      //   {
      //     label: '員工編號',
      //     field: 'username',
      //   },
      //   {
      //     label: '姓名',
      //     field: 'full_name',
      //   },
      //   {
      //     label: '職級',
      //     field: 'level',
      //   },
      //   {
      //     label: '排班身份',
      //     field: 'type_of_user'
      //   },
      //   {
      //     label: '其他',
      //     field: 'pregnant'
      //   },
      //   {
      //     label: '排班狀況',
      //     field: 'can_be_scheduled'
      //   },
      //   {
      //     label: '功能',
      //     field: 'functions'
      //   },
      // ],
      // rows: [
      //   { id:1, name:"John", age: 20, createdAt: '',score: 0.03343 },
      //   { id:2, name:"Jane", age: 24, createdAt: '2011-10-31', score: 0.03343 },
      //   { id:3, name:"Susan", age: 16, createdAt: '2011-10-30', score: 0.03343 },
      //   { id:4, name:"Chris", age: 55, createdAt: '2011-10-11', score: 0.03343 },
      //   { id:5, name:"Dan", age: 40, createdAt: '2011-10-21', score: 0.03343 },
      //   { id:6, name:"John", age: 20, createdAt: '2011-10-31', score: 0.03343 },
      // ],
    };
  },
  methods: {
    isManager() {
      return ['admin', 'manager'].includes(this.role);
    },
    getUsers() {
      let self = this;
      let url = `/api/users`;
      this.$httpClient.get(url)
        .then(function (response) {
          // let flavors = response.data.result.data.flavors;
          // if (flavors.length > 0) {
          //   self.flavors = flavors;
          // } else {
          //   self.flavors = null;
          // }
          console.log(response.data);
        })
        .catch(function (error) {
          // handle error
          popup.error({
            title: error.title,
            html: httpRep.messageJoin(error.message),
          });
          console.log(error);
        });
    },
  },
  mounted() {
    // console.log(this.role);
    // console.log(this.isManager());
    // console.log(this.isSuperuser);
  }
}
</script>

<style scoped>

</style>
