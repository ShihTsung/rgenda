const { merge } = require('webpack-merge');
const common = require('./webpack.common.js');
const exec = require('child_process').exec;

module.exports = merge(common, {
  watch: true,
  mode: 'development',
  devtool: 'inline-source-map',
  resolve: {
    alias: {
      vue: 'vue/dist/vue.js'
    }
  },
  plugins: [
    {
      apply: (compiler) => {
        compiler.hooks.afterEmit.tap('AfterEmitPlugin', (compilation) => {
          exec('docker exec -i schedule_web python manage.py collectstatic --noinput', (err, stdout, stderr) => {
            if (stdout) process.stdout.write(stdout);
            if (stderr) process.stderr.write(stderr);
          });
        });
      }
    }
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
  }
});
