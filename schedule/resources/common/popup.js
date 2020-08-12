import swal from 'sweetalert2'

let config = {
  showCancelButton: false,
  showConfirmButton: true,
  customClass: {
    title: 'modal-title rgenda-text-dark-blue mb-4',
    content: 'mb-4',
    confirmButton: 'btn btn-rgenda',
    cancelButton: 'btn btn-rgenda'
  },
  buttonsStyling: false,
  cancelButtonText: '取消',
  confirmButtonText: '確定',
  reverseButtons: true, // confirm button 在右側
  icon: 'warning',
}

const executeSwal = (msgObj, confirm, cancel) => {
  const msgConfig = Object.assign({}, config, msgObj);
  swal.fire(msgConfig).then((result) => {
    // https://sweetalert2.github.io/#examples
    if (result.value) {
      if (typeof confirm === 'function') {
        confirm();
      }
    } else if (result.dismiss === swal.DismissReason.cancel) {
      // https://sweetalert2.github.io/#handling-dismissals
      if (typeof cancel === 'function') {
        cancel();
      }
    }
  });
}

const loading = (msgObj, confirm, cancel) => {
  config.icon = 'info';
  const newMsgObj = Object.assign({}, {
    allowOutsideClick: false,
    allowEscapeKey: false,
    allowEnterKey: false,
    showConfirmButton: false,
    showCancelButton: false,
    showCloseButton: false,
  }, msgObj);
  executeSwal(newMsgObj, confirm, cancel);
};

const warning = (msgObj, confirm, cancel) => {
  config.icon = 'warning';
  executeSwal(msgObj, confirm, cancel);
}

const success = (msgObj, confirm, cancel) => {
  config.icon = 'success';
  executeSwal(msgObj, confirm, cancel);
}

const error = (msgObj, confirm, cancel) => {
  config.icon = 'error';
  executeSwal(msgObj, confirm, cancel);
}

const info = (msgObj, confirm, cancel) => {
  config.icon = 'info';
  executeSwal(msgObj, confirm, cancel);
}

const close = (msgObj, confirm, cancel) => {
  if (document.getElementsByClassName('swal2-container').length > 0) {
    swal.clickCancel();
  }
}

const popup = {
  success,
  warning,
  error,
  info,
  loading,
  close,
}

export default popup;
