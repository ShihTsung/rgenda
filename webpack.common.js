const path = require('path');
const ASSETS_PATH = '/assets';
const HtmlWebpackPlugin = require('html-webpack-plugin');
const { CleanWebpackPlugin } = require('clean-webpack-plugin');
const VueLoaderPlugin = require('vue-loader/lib/plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');

module.exports = {
  context: path.join(__dirname, '/schedule/resources/src'),
  entry: {
    'account-list': './accounts/list.js',
    'notice-list': './navbar/notice-list.js',
    'department-list': './department/department-list.js',
    'department-edit': './department/department-edit.js',
    'account-detail': './accounts/account-detail.js',
    'demand-list': './demands/list.js',
    'exchange-application-audit': './exchange/application-audit.js',
    'promise-leave': './promise-leave/promise-leave.js',
    'time-adjustment': './time-adjustment/time-adjustment.js',
    'shift-list': './shifts/shift-list.js',
    'station-list': './stations/station-list.js',
    'rgenda': './rgenda.scss',
    'pre-result': './pre-result/pre-result.js',
  },
  output: {
    filename: '[name].bundle.js',
    path: path.join(__dirname, '/schedule/static/assets'),
    publicPath: ASSETS_PATH
  },
  resolve: {
    alias: {
      common: path.join(__dirname, '/schedule/resources/common'),
      components: path.join(__dirname, '/schedule/resources/components'),
      src: path.join(__dirname, '/schedule/resources/src'),
    },
    extensions: ['.js', '.vue', '.json', '.css']
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: 'babel-loader'
      },
      {
        test: /\.vue$/,
        loader: 'vue-loader'
      },
      {
      test: /\.(css|sass|scss)$/,
      use: [
          MiniCssExtractPlugin.loader,
          'css-loader',
          // 'style-loader',
          'sass-loader',
        ],
      },
      {
        test: /\.(png|svg|jpg|gif)$/,
        loader: 'url-loader'
      },
      {
        test: /\.(woff|woff2|eot|ttf|otf)$/,
        loader: 'url-loader'
      },
    ],
  },
  plugins: [
    new CleanWebpackPlugin(),
    new HtmlWebpackPlugin(),
    new MiniCssExtractPlugin({
      filename: "./css/[name].css",
      // chunkFilename: "./css/[id].css",
    }),
    new VueLoaderPlugin(),
  ],
  optimization: {
    splitChunks: {
      cacheGroups: {
        common: {
          name: 'common',
          chunks: 'all'
        }
      }
    }
  },
  performance:{
    hints: false
  },
};
