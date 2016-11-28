const { resolve } = require('path')

module.exports = env => {
  return {
    context: resolve(__dirname, 'src'),
    entry: './index.js',
    output: {
      path: resolve(__dirname, 'dist'),
      filename: 'bundle.js'
    },
    devtool: env.prod ? 'source-map' : 'eval',
    module: {
      loaders: [
        {
          test: /\.elm$/,
          exclude: /elm-stuff/,
          loader: 'elm-webpack-loader?debug=true'
        },
        {
          test: /\.js$/,
          exclude: /node_modules/,
          loader: 'babel-loader'
        },
        {
          test: /\.json$/,
          loader: 'json-loader'
        }
      ],
      noParse: /\.elm$/
    },
    resolve: {
      extensions: [ '.elm', '.js' ]
    }
  }
}
