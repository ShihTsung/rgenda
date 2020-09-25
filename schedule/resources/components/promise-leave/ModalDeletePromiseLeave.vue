<template>
  <!-- modal - del time adjustment -->
  <div class="modal fade" id="modalDeletePromiseLeave" tabindex="-1" role="dialog" aria-hidden="true"
  data-backdrop="static">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header border-bottom-0">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"
          @click="cancelDelete()">
            <span aria-hidden="true">
              <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path d="M24 20.188l-8.315-8.209 8.2-8.282-3.697-3.697-8.212 8.318-8.31-8.203-3.666 3.666 8.321 8.24-8.206 8.313 3.666 3.666 8.237-8.318 8.285 8.203z"/></svg>
            </span>
          </button>
        </div>
        <div class="modal-body text-center pt-0">
          <h3 class="modal-title rgenda-text-dark-blue mb-4">刪除確認</h3>
          <p class="mb-4">一旦刪除記錄，將無法復原。<br>您確定仍要將記錄刪除嗎？</p>
          <div class="row">
            <div class="col mb-2">
              <button class="btn btn-rgenda" type="button"
              @click="cancelDelete()"
              data-dismiss="modal">取消</button>
              <button id="btn-delete" class="btn btn-rgenda"
              @click="destroy()"
              type="button">刪除</button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- \modal - del time adjustment -->
</template>

<script>
import popup from 'common/popup';
import {
  httpRep
} from 'common/helpers';

export default {
  props: {
    csrfToken: {
      type: String,
      default: '',
    },
    deleteItems: {
      type: Array,
      default: []
    }
  },
  methods: {
    destroy() {
      let self = this;
      $('#modalDeletePromiseLeave').modal('hide');

      if (self.deleteItems.length < 1) {
        return;
      }

      popup.loading({
        title: '處理中...',
      });

      let promiseArr = self.deleteItems.map(function (id) {
        let url = `/api/promises/${id}/`;
        const formConfig = {
          headers: {
            'X-CSRFToken': `${self.csrfToken}`
          }
        }
        self.$httpClient.delete(url, formConfig)
          .then(function (response) {
            // debug
            // console.log(`delete time adjustment id = ${id}`);
          })
          .catch(function (error) {
            // handle error
            popup.error({
              title: error.title,
              html: httpRep.messageJoin(error.message),
            });
            console.log(error);
          });
      });

      Promise.all(
        promiseArr
      ).then(function (response) {

        popup.success({
          title: '刪除假勤紀錄',
          text: '請求成功',
        }, function () {
          self.cancelDelete();
          // refresh query result
          self.$parent.query(false);
        });
      }).catch(function (error) {
        // handle error
        popup.error({
          title: error.title,
          html: httpRep.messageJoin(error.message),
        });
        console.log(error);
      });;
    },
    cancelDelete() {
      this.$parent.cancelDelete();
    },
  },
}
</script>
