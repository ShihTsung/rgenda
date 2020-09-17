const { merge } = require('webpack-merge');
const common = require('./webpack.common.js');

module.exports = merge(common, {
  watch: true,
  mode: 'development',
  devtool: 'inline-source-map',
  resolve: {
    alias: {
      vue: 'vue/dist/vue.js'
    }
  }
});
