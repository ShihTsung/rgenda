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
    'account-detail': './accounts/account-detail.js',
    'rgenda': './rgenda.scss',
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
    },
    extensions: ['.js', '.vue', '.json', '.css']
  },
  watch: true,
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
