exports.index = (req, res) ->
  ejs = require 'ejs'

  res.render "index.ejs"