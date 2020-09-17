<template>
  <div
    class="modal fade"
    id="recalculateModal"
    tabindex="-1"
    role="dialog"
    aria-hidden="true"
    data-backdrop="static"
  >
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header border-bottom-0">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">
              <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
                <path
                  d="M24 20.188l-8.315-8.209 8.2-8.282-3.697-3.697-8.212 8.318-8.31-8.203-3.666 3.666 8.321 8.24-8.206 8.313 3.666 3.666 8.237-8.318 8.285 8.203z"
                />
              </svg>
            </span>
          </button>
        </div>
        <div class="modal-body pt-0" v-show="!isConfirmData">
          <div class="mb-4 text-center icon_color_blue">
            <svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" viewBox="0 0 24 24">
              <path
                d="M15.408 23h-15.408v-22h22v9.683c-.622-.296-1.293-.502-2-.603v-3.08h-18v14h11.26c.566.81 1.3 1.49 2.148 2zm2.257-8.669c.402-.206.852-.331 1.335-.331 1.455 0 2.67 1.042 2.941 2.418l1.96-.398c-.456-2.291-2.475-4.02-4.901-4.02-.957 0-1.845.278-2.604.745l-1.396-1.745-1 5h5l-1.335-1.669zm5.335 8.669l-1.396-1.745c-.759.467-1.647.745-2.604.745-2.426 0-4.445-1.729-4.901-4.02l1.96-.398c.271 1.376 1.486 2.418 2.941 2.418.483 0 .933-.125 1.335-.331l-1.335-1.669h5l-1 5z"
              />
            </svg>
          </div>
          <h3 class="modal-title rgenda-text-dark-blue mb-4 text-center">即將重新排班</h3>
          <div class="text-left">
            <div class="form-group row">按下「確認」後，系統會重新計算本月排班，不會保留任何修改結果。</div>
            <div class="row">
              <div class="col mb-2 mt-2 text-center">
                <button class="btn btn-rgenda" type="button" data-dismiss="modal">取消</button>
                <button
                  id="btn-delete"
                  class="btn btn-rgenda"
                  @click="recalculate()"
                  type="button"
                >確認</button>
              </div>
            </div>
          </div>
        </div>
        <div class="modal-body pt-0" v-show="couldRecalculateData && isConfirmData">
          <div class="loader mb-5 mt-4">
            <span></span>
            <span></span>
            <span></span>
          </div>
          <h3 class="modal-title rgenda-text-dark-blue mb-5 mt-5 text-center">重新排班中，請稍候...</h3>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  props: {
    year: {
      type: Number,
      default: 0,
    },
    month: {
      type: Number,
      default: 0,
    },
    getDays: {
      type: Number,
      default: 30,
    },
    isConfirm: {
      type: Boolean,
      default: false,
    },
    couldRecalculate: {
      type: Boolean,
      default: true,
    },
  },
  data(){
    return {
      isConfirmData: this.isConfirm,
      couldRecalculateData: this.couldRecalculate

    };
  },
  methods: {
    async recalculate() {
      await this.$httpClient
        .get(`/api/published-or-not?year=${this.year}&month=${this.month}`)
        .then((response) => {
          if (response.data===true){
            this.couldRecalculateData = false
          }
        this.isConfirmData = true;
        })
        .catch((err) => {
          console.log(err);
        });


      if (this.couldRecalculateData) {
        fetch(
          `/api/recreate-result?start=${this.year}-${this.month}-01&end=${this.year}-${this.month}-${this.getDays}`
        )
          .then((res) => {
            $("#recalculateModal").modal("hide");
            return res.json();
          })
          .then((data) => {
            let name = `Announced${this.month}`;
            let d = new Date(this.year, this.month - 1, this.getDays);
            $.cookie(name, "true1", {
              path: "/",
              expires: d,
            });

            this.$parent.getPreResults();
            this.$parent.getTotalPerDayData();
          })
          .catch((err) => {
            console.log(err);
          });
      }
    },
  },
};
</script>
<style lang="scss" scoped>
.icon_color_blue {
  fill: #37419a;
}

.icon_color_red {
  fill: red;
}

.loader {
  width: 16em;
  height: 8em;
  position: relative;
  overflow: hidden;
  margin: 0 auto;
}

.loader::before,
.loader::after {
  content: "";
  position: absolute;
  bottom: 0;
}

.loader::before {
  width: inherit;
  height: 0.2em;
  background-color: #37419a;
}

.loader::after {
  box-sizing: border-box;
  width: 50%;
  height: inherit;
  border: 0.2em solid #37419a;
  border-radius: 50%;
  left: 25%;
}

.loader span {
  position: absolute;
  width: 5%;
  height: 10%;
  background-color: #37419a;
  border-radius: 50%;
  bottom: 0.2em;
  left: -5%;
  animation: 2s linear infinite;
  transform-origin: 50% -3em;
  animation-name: run, rotating;
}

.loader span:nth-child(2) {
  animation-delay: 0.075s;
}
.loader span:nth-child(3) {
  animation-delay: 0.15s;
}

@keyframes run {
  0% {
    left: -5%;
  }
  10%,
  60% {
    left: calc((100% - 5%) / 2);
  }
  70%,
  100% {
    left: 100%;
  }
}

@keyframes rotating {
  0%,
  10% {
    transform: rotate(0deg);
  }
  60%,
  100% {
    transform: rotate(-1turn);
  }
}
</style>
