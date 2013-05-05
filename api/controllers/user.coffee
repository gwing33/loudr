User = require "../models/users"
mongoose = require "mongoose"

exports.create = (req, res, next) ->
  res.send "creating user..."

exports.get_by_email = (req, res, next) ->
  res.send "getting user: " + req.params.email

exports.login = (req, res, next) ->
  params = JSON.parse req.body

  User.getAuthenticated params.email, params.password, (err, user, reason_id) ->
    throw err  if err
    
    # Defaults to reasons.MAX_ATTEMPTS
    json =
      success: user?
      reason: 'Account is locked, check your email to reactivate your account.'
    
    reasons = User.failedLogin
    switch reason_id
      when reasons.NOT_FOUND
        json.reason = 'We do not seem to have that email address.'
      when reasons.PASSWORD_INCORRECT
        json.reason = 'Password was invalid.'

    res.send json