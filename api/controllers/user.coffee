User = require "../models/usersModel"
mongoose = require "mongoose"
async = require "async"
connect = require "connect"
auth = require "../helpers/_auth"

fail = (err) ->
  json =
    success: false
  json.error = err if err
  
  return json

success = (user) ->
  json =
    user: user
    success: true

  return json

exports.get_user = (req, res, next) ->
  if req.params.email == req.session.user.email
    user = new User req.session.user
    
    return res.send success user.toJson()

  return res.send fail(null)

exports.authed = (req, res, next) ->
  return res.send req.session.user?

# Should attempt to log the user into the site
exports.login = (req, res, next) ->
  # TODO, finish authentication
  if auth.auth_header req.headers.authorization

  # With email and password, validate user
  User.getAuthenticated req.body.email, req.body.password, (err, user, reason_id) ->
    return res.send fail(null) if err # Error out
    
     # If successful user, set session, return json object
    if user?
      req.session.user = user.toJson()
      # req.session.save()

      return res.send success user.toJson()
    
    # Unsuccessful login because...
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

# Should log the user out of the site
exports.logout = (req, res, next) ->
  delete req.session.user

  return res.send
    success: true

exports.update_user = (req, res, next) ->
  # Validate user is logged in
  if req.session.user? and req.session.user._id == req.params.id
    
    # Get the actual user, so can validate against password
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

          return res.send success user.toJson()

  return fail(null)

# Create new user, if successful, log them in
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

    return res.send success user.toJson()


exports.delete_user = (req, res, next) ->
  # Validate user is logged in
  if req.session.user? and req.session.user._id == req.params.id
    # Log them out...because they won't exist
    req.session.user = null

    # Remove them
    User.removeById req.params.id, (err, success) ->
      return res.send { success: !err }
  else
    return res.send { success: false }

