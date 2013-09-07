ejs = require 'ejs'

exports.index = (req, res) ->
  logged_in = req.session.user?
  email = req.session.user.email if logged_in
  
  res.render "index.ejs", 
    logged_in: logged_in,
    email: email


# This won't require login, because it will request a user login via front-end
exports.app = (req, res) ->
  logged_in = req.session.user?
  email = req.session.user.email if logged_in

  res.render "site.ejs",
    logged_in: logged_in
    email: email
