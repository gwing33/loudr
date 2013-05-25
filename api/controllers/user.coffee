User = require "../models/usersModel"
mongoose = require "mongoose"
async = require "async"
connect = require('connect')

fail = (err) ->
  json =
    success: false
  json.error = err if err
  
  return json

exports.get_user = (req, res, next) ->
  if req.params.email is req.session.user.email
    user = new User req.session.user
    tmp_user = user.toJson()
    tmp_user.success = true
    return res.send tmp_user

  return res.send fail(null)

#  User.getByEmail req.params.email, (err, user, reason_id) ->
#    if err
#      return res.send
#        success: false
#    
#    if !user
#      return res.send
#        success: false
#        reason: reason_id
#
#    tmp_user = user.toJson()
#    tmp_user.success = true
#    return res.send tmp_user

exports.login = (req, res, next) ->
  User.getAuthenticated req.body.email, req.body.password, (err, user, reason_id) ->
    return res.send fail(null) if err
    
    if user?
      req.session.user = user.toJson()

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

exports.logout = (req, res, next) ->
  res.session = null

  res.send
    success: true

exports.update_user = (req, res, next) ->
  if req.session.user? and req.session.user._id == req.params.id
    # Do a save
    User.getById req.params.id, (err, user) ->
      return res.send fail(null) if err

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
          return res.send fail(err) if err

          # Update in the session
          req.session.user = user.toJson()

          tmp_user = user.toJson()
          tmp_user.success = true
          return res.send tmp_user

  return fail(null)

exports.create_user = (req, res, next) ->
  new_user = new User
    email: req.body.email
    name:
      first: req.body.first_name
      last: req.body.last_name
    password: req.body.password
   
  # save user to database
  new_user.save (err, user) ->
    return res.send fail(null) if err
    
    req.session.user = user.toJson()

    tmp_user = user.toJson()
    tmp_user.success = true
    return res.send tmp_user

exports.delete_user = (req, res, next) ->
  User.removeById req.params.id, (err, success) ->
    res.send
      success: !err