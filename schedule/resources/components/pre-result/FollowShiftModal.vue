<template>
  <div
    class="modal fade"
    id="followShiftModal"
    tabindex="-1"
    role="dialog"
    aria-hidden="true"
    data-backdrop="static"
  >
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content follow">
        <div class="modal-header border-bottom-0">
          <button
            type="button"
            class="close"
            data-dismiss="modal"
            aria-label="Close"
            @click="cancelFollowEdit()"
          >
            <span aria-hidden="true">
              <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
                <path
                  d="M24 20.188l-8.315-8.209 8.2-8.282-3.697-3.697-8.212 8.318-8.31-8.203-3.666 3.666 8.321 8.24-8.206 8.313 3.666 3.666 8.237-8.318 8.285 8.203z"
                />
              </svg>
            </span>
          </button>
        </div>
        <div class="modal-body text-center pt-0">
          <h3 class="modal-title rgenda-text-dark-blue mb-4">編輯跟班</h3>
          <div class="container-fluid text-left">
            <div class="form-group row">
              <label class="col-sm-4 col-form-label offset-1">跟班</label>
              <select class="col-sm-6 form-control" v-model="follower">
                <option selected disabled="disabled" style="display: none" value></option>
                <option v-for="f in findFollowers()" :key="`d${f.eid}`" :value="f.id">{{f.full_name}}</option>
              </select>
            </div>
            <div class="form-group row">
              <label class="col-sm-4 col-form-label offset-1">帶班</label>
              <select class="col-sm-6 form-control" v-model="mentor">
                <option selected disabled="disabled" style="display: none" value></option>
                <option v-for="t in findMentors()" :key="`k${t.full_name}`" :value="t.id">{{t.full_name}}</option>
              </select>
            </div>
            <div class="form-group row">
              <label class="col-sm-4 col-form-label offset-1">起始日期</label>
              <select class="col-sm-4 col-form-label offset-1" v-model="startDay">
                <option v-for="i in days()" :key="`2${i}`"> {{i}} </option>
              </select> <label class="col-sm-1 col-form-label">日</label>
            </div>
            <div class="form-group row">
              <label class="col-sm-4 col-form-label offset-1">結束日期</label>
              <select class="col-sm-4 col-form-label offset-1" v-model="endDay">
                <option v-for="i in days()" :key="i"> {{i}} </option>
              </select><label class="col-sm-1 col-form-label">日</label>
            </div>
            <div class="row">
              <div class="col mb-2 text-center">
                <button
                  class="btn btn-rgenda"
                  type="button"
                  data-dismiss="modal"
                  @click="cancelFollowEdit()"
                >取消</button>
                <button id="btn-delete" class="btn btn-rgenda" @click="save()" type="button">儲存</button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import popup from "common/popup";
export default {
  props: {
    year:{
      type: Number,
      default: 2020
    },
    month:{
      type: Number,
      default: 1
    },
    getDays:{
      type: Number,
      default: 1
    },
    userData: {
      type: Array,
      default: function () {
        return [];
      },
    },
    mentorData: {
      type: Array,
      default: function () {
        return [];
      },
    },
    followerData: {
      type: Array,
      default: function () {
        return [];
      },
    },
  },
  data() {
    return {
      mentor: "",
      follower: '',
      startDate: '',
      endDate: '',
      startDay: 0,
      endDay: 0,
    };
  },
  computed: {
  },
  methods: {
    cancelFollowEdit() {
      Object.assign(this.$data, this.$options.data.apply(this));
    },
    save() {
      this.startDate = `${this.year}-${this.month}-${this.startDay}`
      this.endDate = `${this.year}-${this.month}-${this.endDay}`
      this.$parent.sendFollowShift({
        mentor: this.mentor,
        follower: this.follower,
        startDate: this.startDate,
        endDate: this.endDate
      });
    },
    findFollowers() {
      let follower = this.userData.filter((i) => {
        return i.type_of_user > 2;
      });

      return follower;
    },
    findMentors() {
      let mentor = this.userData.filter((i) => {
        return i.type_of_user < 3;
      });
      return mentor;
    },
    days(){
      return [...Array(this.getDays+1).keys()].splice(1);
    },
  },
};
</script>

<style scoped>
.follow {
      width: 27vw;
      height: 500px;
      background: white;
      border-radius: 2px;
      box-shadow: 3px 3px 5px rgba(0, 0, 0, 0.3);
    }
</style>
