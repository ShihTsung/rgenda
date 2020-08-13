<template>
<!-- modal begin -->
<div class="modal fade" id="addLicenseModal" tabindex="-1" role="dialog"
aria-labelledby="exampleModalLabel" aria-hidden="true"data-backdrop="static">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header border-bottom-0">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path d="M24 20.188l-8.315-8.209 8.2-8.282-3.697-3.697-8.212 8.318-8.31-8.203-3.666 3.666 8.321 8.24-8.206 8.313 3.666 3.666 8.237-8.318 8.285 8.203z" /></svg>
          </span>
        </button>
      </div>
      <form id="addLiscense" method="post">
        <div class="modal-body pt-0">
          <h3 class="modal-title rgenda-text-dark-blue mb-4 text-center">新增證照</h3>

          <div class="form-group row">
            <label for="liscenseName" class="col-sm-4 col-form-label offset-1">證照名稱</label>
            <div class="col-sm-7">
              <input name="liscenseName" type="text" class="form-control">
            </div>
          </div>

          <div class="form-group row">
            <label for="liscenseDate" class="col-sm-4 col-form-label offset-1">發證日期</label>
            <div class="col-sm-7">
              <input name="liscenseDate" type="date" class="form-control">
            </div>
          </div>
          <div class="form-group row">
            <label for="liscenseDueDate" class="col-sm-4 col-form-label offset-1">證照到期日</label>
            <div class="col-sm-7">
              <input name="liscenseDueDate" type="date" class="form-control">
            </div>
          </div>
          <div class="form-group row">
            <label for="liscenseSource" class="col-sm-4 col-form-label offset-1">發證單位</label>
            <div class="col-sm-7">
              <input name="liscenseSource" type="text" class="form-control">
            </div>
          </div>
          <div class="form-group row">
            <div class="col-sm-4 offset-1">
              <label for="liscensePicture" class="btn btn-info">
                <input type="file" id="liscensePicture"
                accept="image/gif, image/jpeg, image/png"
                class="d-none" ref="uploadFile1"
                @change="processFile1($event)" />
                證照正面
              </label>
            </div>
            <div class="col-sm-7">
              <img :src="noPhoto" class="col-8" ref="preview1">
            </div>
          </div>

          <div class="form-group row">
            <div class="col-sm-4 offset-1">
              <label for="liscensePicture2" class="btn btn-info">
                <input type="file" id="liscensePicture2"
                accept="image/gif, image/jpeg, image/png"
                class="d-none" ref="uploadFile2"
                @change="processFile2($event)" />
                證照背面
              </label>
            </div>
            <div class="col-sm-7">
              <img :src="noPhoto" class="col-8" ref="preview2">
            </div>
          </div>

          <div class="row">
            <div class="col mb-2 mt-2 text-center">
              <button class="btn btn-rgenda" type="button" data-dismiss="modal">取消</button>
              <button id="save" class="btn btn-rgenda" type="button">儲存</button>
            </div>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
<!-- modal end -->
</template>

<script>
import noPhoto from '../../../static/images/no-photo.jpg';

export default {
  data: function() {
    return {
      noPhoto: noPhoto,
      image1: null,
      image2: null,
    };
  },
  methods: {
    processFile1(event) {
      let self = this;
      if (event.target.files.length > 0) {
        self.image1 = event.target.files[0];
        const FR = new FileReader();
        FR.addEventListener("load", function (e) {
          self.$refs["preview1"].src = e.target.result;
        });

        FR.readAsDataURL(event.target.files[0]);
      }
    },
    processFile2(event) {
      let self = this;
      if (event.target.files.length > 0) {
        self.image2 = event.target.files[0];
        const FR = new FileReader();
        FR.addEventListener("load", function (e) {
          self.$refs["preview2"].src = e.target.result;
        });

        FR.readAsDataURL(event.target.files[0]);
      }
    },
  }
}
</script>

<style scoped>

</style>
