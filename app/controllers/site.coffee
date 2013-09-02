ejs = require 'ejs'

exports.index = (req, res) ->
  res.render "index.ejs",
    logged_in: req.session.user?

# This won't require login, because it will request a user login via front-end
exports.app = (req, res) ->
  res.render "site.ejs",
    logged_in: req.session.user?
