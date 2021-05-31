const path = require("path");

module.exports = {
  entry: "./app/frontend/index.js",
  devtool: "source-map",
  output: {
    path: path.resolve(__dirname, "app", "assets", "javascripts"),
    filename: "action_text_syntax_highlighter.js",
  },
  resolve: {
    extensions: [".js"],
    modules: [
      path.resolve('./node_modules')
    ]
  },
  module: {
    rules: [
      {
        test: /\.js/,
        use: {
          loader: 'esbuild-loader',
          options: { target: 'es2016' }
        },
      },
      {
        test: /\.(s[ac]|c)ss$/,
        use: {
          loader: "css-loader",
          options: {
            importLoaders: 1
          }
        },
      },
    ],
  },
};