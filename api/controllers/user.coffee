User = require "../models/users"
mongoose = require "mongoose"

exports.create_user = (req, res, next) ->
  new_user = new User
    email: req.params.email
    first_name: req.params.first_name
    last_name: req.params.last_name
    password: req.params.password
   
  # save user to database
  
  new_user.save (err) ->
    if err
      res.send
        success: false
    else
      res.send @
    

exports.get_by_email = (req, res, next) ->
  res.send "getting user: " + req.params.email

exports.login = (req, res, next) ->
  User.getAuthenticated req.params.email, req.params.password, (err, user, reason_id) ->
    if err
      res.send
        success: false
    
    # Defaults to reasons.MAX_ATTEMPTS
    json =
      success: user?
      reason: 'Account is locked, check your email to reactivate your account.'
    
    req.session.user_id = 123 if json.success

    reasons = User.failedLogin
    switch reason_id
      when reasons.NOT_FOUND
        json.reason = 'We do not seem to have that email address.'
      when reasons.PASSWORD_INCORRECT
        json.reason = 'Password was invalid.'

    res.send json