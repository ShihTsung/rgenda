import axios from 'axios';
import qs from 'qs';
import tip from './tip';
import { isObject } from 'lodash';

const ERROR_TYPE = {
  default: 'default',
  system: 'system'
};

class ApiError {
  constructor(title, message, errorType, innerError) {
    this.name = 'ApiError';
    this.title = title || '';
    this.message = message || 'Default Message';
    this.errorType = errorType || ERROR_TYPE.default;
    this.innerError = innerError;
    this.stack = (new Error()).stack;
  }
};
ApiError.prototype = Object.create(Error.prototype);
ApiError.prototype.constructor = ApiError;

const httpClient = axios.create({
  baseURL: '',
  timeout: 10000,
  // Response 的 data type: json / blob / document / arraybuffer / text / stream
  responseType: 'json',
  withCredentials: true
});

// POST 傳參序列化(添加請求攔截器)
httpClient.interceptors.request.use(
  config => {
    if (
      config.method === 'post' ||
      config.method === 'put' ||
      config.method === 'patch'
    ) {
      // Content-Type 對於 POST、PUT 和 PATCH 才有意義
      config.headers['Content-Type'] = 'application/json; charset=UTF-8';
      // 序列化
      config.data = JSON.stringify(config.data)
    } else if (
      config.method === 'delete' ||
      config.method === 'get' ||
      config.method === 'head'
    ) {
      // QueryString 序列化
      config.paramsSerializer = function (params) {
        // arrayFormat: indices、brackets、repeat
        return qs.stringify(params, {
          arrayFormat: 'indices'
        });
      }
    }

    // if (localStorage.token) {
    //   config.headers.Authorization = localStorage.token;
    // }

    return config;
  },
  error => {
    tip.error('Request Error');

    console.log('req error')
    return error;
  }
);

// 返回狀態判斷(添加 Response 攔截器)
httpClient.interceptors.response.use(
  response => {
    if (response.headers['content-type'].indexOf('json') === -1) {
      // 返回的 data 不是 json (或是 json 但 server 的 content-type 設置不準確)
      return response;
    }
    // 僅處理 json data
    let json;
    if (response.request.responseType === 'arraybuffer' && response.data.toString() === '[object ArrayBuffer]') {
      // 返回的 data 是 arraybuffer，內容是 json
      // 備註：可能內容不是 json，這裏暫未處理
      const text = Buffer.from(response.data).toString('utf8');
      // console.log(text)
      json = JSON.parse(text);
    } else {
      // 備註：不是 arraybuffer 可能會是 blob 等，這裏暫未處理
      json = response.data;
    }

    // console.log(json.error)
    if (json && json.url) {
      top.location = json.url;
    } else if (json && json.error) {
      // tip.error(json.error.title);
      console.log(json)
      let errMsg = !isObject(json.error.message) ? [json.error.message] : json.error.message;
      return Promise.reject(new ApiError(json.error.title, errMsg));
    }
    return response;
  },
  error => {
    tip.error('Response Error');

    console.log('res error')
    // 返回 response 裏的錯誤信息
    let errMsg = !isObject(error.message) ? [error.message] : error.message;
    return Promise.reject(new ApiError(error.title || '', errMsg, ERROR_TYPE.system, error));
  }
)

// 將 Axios 的實例封裝成一個 plugin ,方便 Vue.use(xxxx)
export default {
  install: function (Vue, option = {}) {
    // 1.通過 Vue.httpClient 調用
    Vue.httpClient = httpClient;
    // 2.通過 this.$httpClient 調用
    Vue.prototype.$httpClient = httpClient;
  }
}
