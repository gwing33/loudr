ejs = require 'ejs'
fs = require 'fs'
marked = require 'marked'

exports.index = (req, res) ->
  page = req.params.page
  
  unless page?
    page = 'overview'

  get_html_from_md page, (err, html) ->
    html = 'Loading API Documents' if err?
    
    res.render "docs/index.ejs",
      view: html

exports.render_partial_md = (req, res) ->
  get_html_from_md req.params.page, (err, html) ->
    return res.send 404 if err?
  
    res.send html

get_html_from_md = (file, cb) ->
  doc_loc = __dirname + '/../views/docs/' + file.toLowerCase() + '.md'

  fs.readFile doc_loc, 'utf8', (err, data) ->
    return cb 404, null if err?
    
    cb null, marked(data)