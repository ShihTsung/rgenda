import Vue from 'vue';
import Toasted from 'vue-toasted';

Vue.use(Toasted);

const config = {
  iconPack: 'fontawesome', // set your iconPack, defaults to material. material|fontawesome|custom-class
  position: "top-right",
  duration: 5000,
  action: {
    // text: 'Close',
    icon: 'close',
    onClick: (e, toastObject) => {
      toastObject.goAway(0);
    }
  }
};

const show = (message, msgObj) => {
  msgObj = Object.assign({}, config, msgObj);

  Vue.toasted.show(message, msgObj);
};

const success = (message, msgObj) => {
  msgObj = Object.assign({
    theme: 'outline',
    icon: {
      name: 'check'
    },
  }, config, msgObj);

  Vue.toasted.success(message, msgObj);
};

const error = (message, msgObj) => {
  msgObj = Object.assign({
    theme: 'bubble',
    icon: {
      name: 'warning'
    },
  }, config, msgObj);

  Vue.toasted.error(message, msgObj);
};

const tip = {
  success,
  error,
  show,
};

export default tip;
