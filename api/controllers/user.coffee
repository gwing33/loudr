User = require "../models/usersModel"
mongoose = require "mongoose"
async = require "async"

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
  # Do a save
  User.getById req.params.id, (err, user) ->
    if err
      res.send
        success: false

    async.waterfall [
      (cb) ->
        if req.params.new_password
          user.comparePassword req.params.password, (err, isMatch) ->
            cb err if err

            user.set('password', req.params.new_password) if isMatch
            cb null, user
        else
          cb null, user
      , (user, cb) ->
        user.set('full_name', req.params.full_name) if req.params.full_name

        user.save (err, user) ->
          cb err if err
          
          cb null, user
      ], (err, user) ->
        if err
          res.send
            success: false
            error: err

        tmp_user = user.toJson()
        tmp_user.success = true
        return res.send tmp_user


  

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