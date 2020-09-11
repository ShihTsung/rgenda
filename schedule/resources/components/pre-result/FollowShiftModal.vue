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
            <div class="editCategory">
              <h4 class="category-title">跟班</h4>
              <select class="category-option" v-model="follower">
                <option selected disabled="disabled" style="display: none" value></option>
                <option v-for="f in findFollowers()" :key="f.eid" :value="f.id">{{f.full_name}}</option>
              </select>
            </div>
            <div class="editCategory">
              <h4 class="category-title">帶班</h4>
              <select class="category-option" v-model="mentor">
                <option selected disabled="disabled" style="display: none" value></option>
                <option v-for="t in findMentors()" :key="t.full_name" :value="t.id">{{t.full_name}}</option>
              </select>
            </div>
            <div class="editCategory">
              <h4 class="category-title">起始日期</h4>
              <input class="category-date" type="date" v-model="startDate" />
            </div>
            <div class="editCategory">
              <h4 class="category-title">結束日期</h4>
              <input class="category-date" type="date" v-model="endDate" />
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
    pickedMentor: {
      type: Object,
      default: function () {
        return {
          id: 0,
          full_name: "",
        };
      },
    },
  },
  data() {
    return {
      mentor: "",
      follower: '',
      startDate: '',
      endDate: ''
    };
  },
  computed: {},
  methods: {
    cancelFollowEdit() {
      Object.assign(this.$data, this.$options.data.apply(this));
    },
    save() {
      console.log(this.mentor);
      console.log(this.follower);
      console.log(this.startDate);
      console.log(this.endDate);
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
  },
};
</script>

<style>
.follow {
      width: 27vw;
      height: 500px;
      background: white;
      border-radius: 2px;
      box-shadow: 3px 3px 5px rgba(0, 0, 0, 0.3);
    }
</style>
