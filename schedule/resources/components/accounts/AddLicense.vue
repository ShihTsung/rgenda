<template>
<!-- modal begin -->
<div class="modal fade" id="addLicenseModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-backdrop="static">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header border-bottom-0">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"
        @click="cancel()">
          <span aria-hidden="true">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path d="M24 20.188l-8.315-8.209 8.2-8.282-3.697-3.697-8.212 8.318-8.31-8.203-3.666 3.666 8.321 8.24-8.206 8.313 3.666 3.666 8.237-8.318 8.285 8.203z" /></svg>
          </span>
        </button>
      </div>
      <form id="addLicense" method="post">
        <div class="modal-body pt-0">
          <h3 class="modal-title rgenda-text-dark-blue mb-4 text-center">新增證照</h3>

          <div class="form-group row">
            <label class="col-sm-4 col-form-label offset-1">證照名稱</label>
            <div class="col-sm-7">
              <input v-model="licenseName" type="text" class="form-control">
            </div>
          </div>

          <div class="form-group row">
            <label class="col-sm-4 col-form-label offset-1">發證日期</label>
            <div class="col-sm-7">
              <date-picker
              v-model="startDate"
              :masks="{L: 'YYYY-MM-DD'}"
              :is-required="true"
              :popover="{visibility: 'focus'}"
              ></date-picker>

            </div>
          </div>
          <div class="form-group row">
            <label class="col-sm-4 col-form-label offset-1">證照到期日</label>
            <div class="col-sm-7">
              <date-picker
              v-model="expiryDate"
              :masks="{L: 'YYYY-MM-DD'}"
              :is-required="true"
              :popover="{visibility: 'focus'}"
              ></date-picker>

            </div>
          </div>
          <div class="form-group row">
            <label class="col-sm-4 col-form-label offset-1">發證單位</label>
            <div class="col-sm-7">
              <input v-model="issuer" type="text" class="form-control">
            </div>
          </div>
          <div class="form-group row">
            <div class="col-sm-4 offset-1">
              <label for="licensePicture" class="btn btn-info">
                <input type="file" id="licensePicture"
                accept="image/gif, image/jpeg, image/png"
                class="d-none" ref="uploadFile1"
                @change="processFile1($event)" />
                證照正面
              </label>
            </div>
            <div class="col-sm-7">
              <img :src="defaultImg" class="col-8" ref="preview1">
            </div>
          </div>

          <div class="form-group row">
            <div class="col-sm-4 offset-1">
              <label for="licensePicture2" class="btn btn-info">
                <input type="file" id="licensePicture2"
                accept="image/gif, image/jpeg, image/png"
                class="d-none" ref="uploadFile2"
                @change="processFile2($event)" />
                證照背面
              </label>
            </div>
            <div class="col-sm-7">
              <img :src="defaultImg" class="col-8" ref="preview2">
            </div>
          </div>

          <div class="row">
            <div class="col mb-2 mt-2 text-center">
              <button class="btn btn-rgenda" type="button" data-dismiss="modal"
              @click="cancel()">取消</button>
              <button id="save" class="btn btn-rgenda" type="button"
              @click="store()">儲存</button>
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
import popup from 'common/popup';
import {
  httpRep
} from 'common/helpers';
import axios from 'axios';
import moment from 'moment';
import DatePicker from 'v-calendar/lib/components/date-picker.umd';
import defaultImg from '../../../static/images/no-photo.jpg';

export default {
  components: {
    'date-picker': DatePicker,
  },
  props: {
    userId: {
      type: Number,
      default: 0,
    },
    username: {
      type: String,
      default: '',
    },
    csrfToken: {
      type: String,
      default: '',
    },
  },
  data: function() {
    return {
      defaultImg: defaultImg,
      image1: null,
      image2: null,
      startDate: moment().toDate(), // Must be Date Object
      expiryDate: moment().add(1, 'y').toDate(), // Must be Date Object,
      licenseName: '',
      issuer: '',
    };
  },
  methods: {
    processFile1(event) {
      let self = this;
      if (event.target.files.length > 0) {
        self.image1 = event.target.files[0];
        const fr = new FileReader();
        fr.addEventListener('load', function (e) {
          self.$refs['preview1'].src = e.target.result;
        });

        fr.readAsDataURL(event.target.files[0]);
      }
    },
    processFile2(event) {
      let self = this;
      if (event.target.files.length > 0) {
        self.image2 = event.target.files[0];
        const fr = new FileReader();
        fr.addEventListener('load', function (e) {
          self.$refs['preview2'].src = e.target.result;
        });

        fr.readAsDataURL(event.target.files[0]);
      }
    },
    validate() {
      let valid = true;
      if (this.licenseName === '' || this.issuer === '' || this.startDate === '' ||
        this.expiryDate === '' || this.image1 === null || this.image2 === null
      ) {
        valid = false;
      }

      return valid;
    },
    store() {
      if (!this.validate()) {
        popup.warning({
          title: '驗證錯誤',
          text: '請檢查所有欄位是否已填寫，檔案是否已上傳',
        });
        return false;
      }

      let url = `/api/licenses/`;
      const formConfig = {
        headers: {
          'X-CSRFToken': `${this.csrfToken}`,
          'content-type': 'multipart/form-data',
        }
      }
      let formData = new FormData();
      formData.append('name', this.licenseName);
      formData.append('date', moment(this.startDate).format('YYYY-MM-DD'));
      formData.append('due', moment(this.expiryDate).format('YYYY-MM-DD'));
      formData.append('source', this.issuer);
      formData.append('license_pic', this.image1);
      formData.append('license_pic_2', this.image2);
      formData.append('user', this.userId);

      popup.loading({
        title: '處理中...',
      });

      axios.post(url, formData, formConfig)
        .then(function (response) {
          popup.success({
            title: '新增證照',
            text: '請求成功',
          }, function () {
            location.reload();
          });
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
    resetFormData() {
      let form = document.getElementById('addLicense');
      form.reset();
      this.image1 = null;
      this.image2 = null;
      this.licenseName = '';
      this.startDate = moment().toDate();
      this.expiryDate = moment().add(1, 'y').toDate();
      this.issuer = '';
      this.$refs['preview1'].src = this.defaultImg;
      this.$refs['preview2'].src = this.defaultImg;
    },
    cancel() {
      this.resetFormData();
    }
  },
}
</script>
