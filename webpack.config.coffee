path              = require('path')
webpack           = require('webpack')
HtmlWebpackPlugin = require('html-webpack-plugin')
CopyWebpackPlugin = require('copy-webpack-plugin')

module.exports =
  entry: './coffee/router'

  output:
    filename: '[name].[chunkhash].js'
    path: './dist'
    libraryTarget: 'umd'
    publicPath: '/'

  module:
    loaders: [
      {
        test: /\.coffee$/
        loaders: ['coffee', 'cjsx', 'coffee-import']
      }
      {
        test: /\.css$/
        loaders: ['style', 'css']
      }
      {
        test: /\.scss$/
        loaders: ['style', 'css', 'resolve-url', 'sass']
      }
      {
        test: /\.(eot|woff2|woff|svg|ttf|otf|png|ico)$/
        loaders: ['file']
      }
    ]

   plugins: [
      new HtmlWebpackPlugin(
        template: 'index.html'
        minify:
          collapseWhitespace: true
      )
      new CopyWebpackPlugin([
        {
          from: 'img/favicon.ico'
          to: 'favicon.ico'
        }
      ])
      new webpack.DefinePlugin(
        __PROD__: process.env.BUILD_PROD is 'true'
      )
    ]

  resolve:
    root: [path.resolve('./coffee'), path.resolve('./')]
    extensions: ['', '.js', '.coffee', '.scss', '.css', '.svg']
