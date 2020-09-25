<template>
  <div
    id="checkPass"
    class="modal fade"
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
        <div class="modal-body pt-0">
          <div class="mb-4 text-center icon-color-blue">
            <svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" viewBox="0 0 24 24"><path d="M5.48 10.089l1.583-1.464c1.854.896 3.028 1.578 5.11 3.063 3.916-4.442 6.503-6.696 11.312-9.688l.515 1.186c-3.965 3.46-6.87 7.314-11.051 14.814-2.579-3.038-4.301-4.974-7.469-7.911zm12.52 3.317v6.594h-16v-16h15.141c.846-.683 1.734-1.341 2.691-2h-19.832v20h20v-11.509c-.656.888-1.318 1.854-2 2.915z"/></svg>
          </div>
          <h3 class="modal-title rgenda-text-dark-blue mb-4 text-center">檢核條件皆通過</h3>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {

}
</script>

<style lang="scss" scoped>
  .icon-color-blue {
    fill: #37419a;
  }
</style>
