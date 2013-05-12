User = require "../models/usersModel"
mongoose = require "mongoose"

exports.create_user = (req, res, next) ->
  new_user = new User
    email: req.params.email
    first_name: req.params.first_name
    last_name: req.params.last_name
    password: req.params.password
   
  # save user to database
  new_user.save (err, user) ->
    if err
      res.send
        success: false
    else
      tmp_user = user.toJson()
      tmp_user.success = true
      return res.send tmp_user

exports.delete_user = (req, res, next) ->
  User.removeById req.params.id, (err, success) ->
    res.send
      success: !err

exports.update_user = (req, res, next) ->
  if(req.params.password)
    # Do a save
    User.getById req.params.id, (err, user) ->
      if err
        res.send
          success: false

      # See if password matches, if it does, set the new password
      matched = false

      user.comparePassword req.params.old_password, (err, isMatch) ->
        matched = isMatch

      user.set('password', req.params.password)
      user.set('full_name', req.params.name) if req.params.name

      user.save (err, user) ->
        if err
          res.send
            success: false
        else
          tmp_user = user.toJson()
          tmp_user.success = true
          return res.send tmp_user
  else
    # just update
    User.update 
      _id: req.params.id
    , req.params, (err, numberAffected, raw) ->
      if err
        res.send
          success: false

      console.log numberAffected, raw
  

exports.get_by_email = (req, res, next) ->
  res.send "getting user: " + req.params.email

exports.login = (req, res, next) ->
  User.getAuthenticated req.params.email, req.params.password, (err, user, reason_id) ->
    if err
      res.send
        success: false
    
    if user?
      # req.session.user_id = 123 if json.success
      tmp_user = user.toJson()
      tmp_user.success = true
      return res.send tmp_user

    # Defaults to reasons.MAX_ATTEMPTS
    json =
      success: false
      reason: 'Account is locked, check your email to reactivate your account.'

    reasons = User.failedLogin
    switch reason_id
      when reasons.NOT_FOUND
        json.reason = 'We do not seem to have that email address.'
      when reasons.PASSWORD_INCORRECT
        json.reason = 'Password was invalid.'

    res.send json