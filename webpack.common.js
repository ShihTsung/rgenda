const path = require('path');
const ASSETS_PATH = '/assets';
const HtmlWebpackPlugin = require('html-webpack-plugin');
const { CleanWebpackPlugin } = require('clean-webpack-plugin');
const VueLoaderPlugin = require('vue-loader/lib/plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');

module.exports = {
  context: path.join(__dirname, '/schedule/resources'),
  entry: {
    index: './index.js',
  },
  output: {
    filename: '[name].bundle.js',
    path: path.join(__dirname, '/schedule/static/assets'),
    publicPath: ASSETS_PATH
  },
  resolve: {
    alias: {
      common: path.join(__dirname, '/schedule/resources/common'),
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
          // 'style-loader',
          // 'sass-loader',
          {
            loader: MiniCssExtractPlugin.loader
          },
          'css-loader',
        ],
      },
      {
        test: /\.(png|svg|jpg|gif)$/,
        loader: 'file-loader'
      },
      {
        test: /\.(woff|woff2|eot|ttf|otf)$/,
        loader: 'file-loader'
      },
    ],
  },
  plugins: [
    new CleanWebpackPlugin(),
    new HtmlWebpackPlugin(),
    new VueLoaderPlugin(),
    new MiniCssExtractPlugin({
      filename: "[name].css",
      chunkFilename: "[id].css"
    }),
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
