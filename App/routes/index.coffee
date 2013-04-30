exports.index = (req, res) ->
    ejs = require 'ejs'

    body_html = 'nope'
    res.render '../views/index.ejs', hw: 'Fuck yes', (err, html) ->
        body_html = html
        return false
    console.log body_html

    res.render "_layout.ejs",
        title: 'Loudr'
        css: ''
        body_css_class: ''
        body: body_html
        js: ''