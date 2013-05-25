User = require "../models/usersModel"
mongoose = require "mongoose"
async = require "async"
connect = require('connect')

exports.get_user = (req, res, next) ->
  User.getByEmail req.params.email, (err, user, reason_id) ->
    if err
      return res.send
        success: false
    
    if !user
      return res.send
        success: false
        reason: reason_id


    tmp_user = user.toJson()
    tmp_user.success = true
    return res.send tmp_user

exports.login = (req, res, next) ->
  User.getAuthenticated req.body.email, req.body.password, (err, user, reason_id) ->
    if err
      return res.send
        success: false
    
    if user?
      async.waterfall [
        (cb) ->
          req.session.regenerate (err) ->
            cb err
        ], (err) ->
          if err
            return res.send
              success: false

          req.session.email = user.email
          req.session.user_id = user._id
          
          # req.session.user_id = 123 if json.success
          tmp_user = user.toJson()
          tmp_user.success = true
          return res.send tmp_user
    else
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

exports.logout = (req, res, next) ->
  res.session.destroy (err) ->
    # Dunno What to do here...
  
  res.send
    success: true

exports.update_user = (req, res, next) ->
  # Do a save
  User.getById req.params.id, (err, user) ->
    if err
      return res.send
        success: false

    async.waterfall [
      (cb) ->
        if req.body.new_password
          user.comparePassword req.body.password, (err, isMatch) ->
            cb err if err

            user.set('password', req.body.new_password) if isMatch
            cb null, user
        else
          cb null, user
      , (user, cb) ->
        user.set('name.full', req.body.full_name) if req.body.full_name

        user.save (err, user) ->
          cb err if err
          
          cb null, user
      ], (err, user) ->
        if err
          return res.send
            success: false
            error: err

        tmp_user = user.toJson()
        tmp_user.success = true
        return res.send tmp_user

exports.create_user = (req, res, next) ->
  new_user = new User
    email: req.body.email
    name:
      first: req.body.first_name
      last: req.body.last_name
    password: req.body.password
   
  # save user to database
  new_user.save (err, user) ->
    if err
      return res.send
        success: false
    else
      tmp_user = user.toJson()
      tmp_user.success = true
      return res.send tmp_user

exports.delete_user = (req, res, next) ->
  User.removeById req.params.id, (err, success) ->
    res.send
      success: !err