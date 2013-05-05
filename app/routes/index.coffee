exports.index = (req, res) ->
    ejs = require 'ejs'

    body_html = ''
    
    res.render '../views/index.ejs', (err, html) ->
        body_html = html
        return false

    res.render "_layout.ejs",
        title: 'Loudr'
        css: ''
        body_css_class: ''
        body: body_html
        js: ''