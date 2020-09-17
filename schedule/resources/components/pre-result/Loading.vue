<template>
  <div id="loading">
    <div class="cssload-container">
      <div class="cssload-progress cssload-float cssload-shadow">
        <div class="cssload-progress-item"></div>
      </div>
    </div>
    <h3 class="loading-text">{{text}}</h3>
  </div>
</template>
<script>
  export default {
    props: {
      text: {
        type: String,
        default: '',
      }
    },
  }
</script>
<style scpoed lang="scss">
#loading {
  width: 27vw;
  height: 300px;
  background: white;
  position: absolute;
  top: 25vh;
  left: 28vw;
  border-radius: 2px;
  box-shadow: 3px 3px 5px rgba(0, 0, 0, 0.3);
  z-index: 99;

  .loading-text {
    position: absolute;
    bottom: 1.5rem;
    left: 50%;
    transform: translateX(-50%);
    color: #37419a;
  }

  .cssload-container.done:before {
    top: -50%;
  }
  .cssload-container.done:after {
    bottom: -50%;
  }

  .cssload-progress {
    position: absolute;
    top: 40%;
    left: 50%;
    transform: translateX(-50%) translateY(-50%);
    -o-transform: translateX(-50%) translateY(-50%);
    -ms-transform: translateX(-50%) translateY(-50%);
    -webkit-transform: translateX(-50%) translateY(-50%);
    -moz-transform: translateX(-50%) translateY(-50%);
    transform-origin: center;
    -o-transform-origin: center;
    -ms-transform-origin: center;
    -webkit-transform-origin: center;
    -moz-transform-origin: center;
  }
  .cssload-progress .cssload-progress-item {
    text-align: center;
    width: 97px;
    height: 97px;
    line-height: 97px;
    border: 2px solid #37419a;
    border-radius: 50%;
  }
  .cssload-progress .cssload-progress-item:before {
    content: "";
    position: absolute;
    top: 0;
    left: 50%;
    margin-top: -3px;
    margin-left: 0px;
    width: 44px;
    height: 44px;
    border-top: solid 10px #37419a;
    border-right: solid 10px #37419a;
    border-top-right-radius: 100%;
    transform-origin: left bottom;
    -o-transform-origin: left bottom;
    -ms-transform-origin: left bottom;
    -webkit-transform-origin: left bottom;
    -moz-transform-origin: left bottom;
    animation: spin 3.45s linear infinite;
    -o-animation: spin 3.45s linear infinite;
    -ms-animation: spin 3.45s linear infinite;
    -webkit-animation: spin 3.45s linear infinite;
    -moz-animation: spin 3.45s linear infinite;
  }
  .cssload-progress.cssload-float .cssload-progress-item:before {
    border-top-width: 2px;
    margin-top: 0px;
    height: 49px;
  }
  .cssload-progress.cssload-float.cssload-shadow:before {
    border-top-width: 2px;
    margin-top: -40px;
    height: 49px;
  }
  .cssload-progress.cssload-shadow:before {
    content: "";
    position: absolute;
    top: 40%;
    left: 50%;
    margin: -42px 0 0 12px;
    width: 44px;
    height: 44px;
    border-top: solid 10px rgb(221, 221, 221);
    border-right: solid 10px rgb(221, 221, 221);
    border-top-right-radius: 100%;
    z-index: -1;
    transform-origin: left bottom;
    -o-transform-origin: left bottom;
    -ms-transform-origin: left bottom;
    -webkit-transform-origin: left bottom;
    -moz-transform-origin: left bottom;
    animation: spin 3.45s linear infinite;
    -o-animation: spin 3.45s linear infinite;
    -ms-animation: spin 3.45s linear infinite;
    -webkit-animation: spin 3.45s linear infinite;
    -moz-animation: spin 3.45s linear infinite;
  }
  .cssload-progress.cssload-shadow:after {
    content: "";
    position: absolute;
    top: 40%;
    left: 50%;
    width: 97px;
    height: 97px;
    color: rgb(221, 221, 221);
    text-align: center;
    line-height: 97px;
    border: 2px solid rgb(221, 221, 221);
    margin: -39px 0 0 -39px;
    z-index: -1;
    border-radius: 50%;
    -o-border-radius: 50%;
    -ms-border-radius: 50%;
    -webkit-border-radius: 50%;
    -moz-border-radius: 50%;
    transform-origin: center;
    -o-transform-origin: center;
    -ms-transform-origin: center;
    -webkit-transform-origin: center;
    -moz-transform-origin: center;
  }

  @keyframes spin {
    100% {
      transform: rotate(360deg);
    }
  }

  @-o-keyframes spin {
    100% {
      -o-transform: rotate(360deg);
    }
  }

  @-ms-keyframes spin {
    100% {
      -ms-transform: rotate(360deg);
    }
  }

  @-webkit-keyframes spin {
    100% {
      -webkit-transform: rotate(360deg);
    }
  }

  @-moz-keyframes spin {
    100% {
      -moz-transform: rotate(360deg);
    }
  }
}
</style>
