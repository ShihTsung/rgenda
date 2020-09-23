<template>
  <div>

    <div class="d-flex">
      <div class="rounded d-flex symbol-square">
      </div>
      <div class="col mb-2 pl-2">
        <h6>個人資訊</h6>
      </div>
    </div>

    <div class="container-fluid border rounded">
      <template v-if="profile">
        <div class="from-group row">
          <label class="col-sm-2 col-form-label">部門</label>
          <div class="col-sm-10"><span class="form-control-plaintext">{{ profile.department}}</span></div>
        </div>
        <div class="from-group row">
          <label class="col-sm-2 col-form-label">姓名</label>
          <div class="col-sm-4"><span class="form-control-plaintext">{{ profile.fullName}}</span></div>
          <label class="col-sm-2 col-form-label">工號</label>
          <div class="col-sm-4"><span class="form-control-plaintext">{{ profile.eid}}</span></div>
        </div>
        <div class="from-group row">
          <label class="col-sm-2 col-form-label">職稱</label>
          <div class="col-sm-4"><span class="form-control-plaintext">{{ profile.typeOfUser}}</span></div>
          <label class="col-sm-2 col-form-label">職等</label>
          <div class="col-sm-4"><span class="form-control-plaintext">{{ profile.level}}</span></div>
        </div>
        <div class="from-group row">
          <label class="col-sm-2 col-form-label">特休</label>
          <div class="col-sm-10"><span class="form-control-plaintext">--</span></div>
        </div>
      </template>
      <template v-else>
        <div class="text-center"><p class="form-control-plaintext">無資料</p></div>
      </template>
    </div>
  </div>

</template>

<script>
export default {
  props: {
    userId: {
      type: Number,
      default: 0,
    },
  },
  data() {
    return {
      profile: null,
    };
  },
  methods: {
    getUser() {
      let self = this;
      let url = `/api/users/${self.userId}?mode=table`;
      self.$httpClient.get(url)
        .then(function (response) {
          let data = response.data;
          if (Object.keys(data).length > 0) {
            self.profile = self.$_personal_transformer(data);
          } else {
            self.profile = null;
          }
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
    $_personal_transformer(obj) {
      return {
        id: obj.id,
        username: obj.username,
        department: obj.department.name,
        eid: obj.eid,
        fullName: obj.full_name,
        level: obj.level,
        typeOfUser: this.$getUserTypeString(obj.type_of_user),
      };
    },
  },
  mounted() {},
  watch: {
    userId(newVal, oldVal) {
      if (newVal == 0) {
        this.profile = null;
      } else {
        if (newVal !== oldVal) {
          this.getUser();
        }
      }
    }
  }
}
</script>
