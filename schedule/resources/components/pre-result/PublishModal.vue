<template>
  <div
    class="modal fade"
    id="publishModal"
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
            @click="cancelPublish()"
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
          <div class="plane" v-if="status===1 || status ===3">
          <svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" viewBox="0 0 24 24"><path d="M24 0l-6 22-8.129-7.239 7.802-8.234-10.458 7.227-7.215-1.754 24-12zm-15 16.668v7.332l3.258-4.431-3.258-2.901z"/></svg>
        </div>
          <h3 class="modal-title rgenda-text-dark-blue mb-4"
              v-if="status===1">即將發佈班表</h3>
          <h5 class="a-content" v-if="status===1">發布後，即無法再重新排班</h5>
          <h3 class="modal-title rgenda-text-dark-blue mb-4"
              v-if="status===2">發佈中</h3>
          <h3 class="modal-title rgenda-text-dark-blue mb-4"
              v-if="status===3">發佈完成</h3>
          <h3 class="modal-title rgenda-text-dark-blue mb-4"
              v-if="status===0">請先檢核再發布！</h3>
          <div class="row">
            <div class="col mb-2 text-center">
              <button
                id="btn-delete"
                class="btn btn-rgenda"
                @click="save()"
                type="button"
                v-if="status===1 || status===3 || status===0">確定</button>
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
    status: {
      type: Number,
      default: 0,
    },
    year: {
      type: Number,
      default: 2020
    },
    month:{
      type: Number,
      default: 1
    }
  },
  data() {
    return {
    // 狀態碼：
    // 0 => nothing
    // 1 => 顯示 modal
    // 2 => 發佈中
    // 3 => 發佈完成

    };
  },
  computed: {},
  methods: {
    cancelPublish() {
      Object.assign(this.$data, this.$options.data.apply(this));
    },
    save() {

      if (this.status == 1){
        this.$emit('update:status', 2);
        this.$httpClient
        .get(`/api/publish-results?year=${this.year}&month=${this.month}`)
        .then(res=>{
          this.$emit('update:status', 3);
        });
      }
      if (this.status == 3 || this.status == 0){
        $("#publishModal").modal('hide');
        this.$emit('update:status', 0);
      }


    },
  },
};
</script>


<style>
</style>
