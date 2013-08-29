ejs = require 'ejs'

exports.index = (req, res) ->
  res.render "docs/index.ejs"


# This will return the MD file as HTML that gets requested, otherwise, 404
exports.render_md = (req, res) ->
  fs = require 'fs'
  marked = require 'marked'

  doc_loc = __dirname + '/../views/docs/' + req.params.page + '.md'

  fs.readFile doc_loc, 'utf8', (err, data) ->
    return res.send 404 if err?
    
    res.send marked(data)