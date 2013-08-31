User = require "../models/usersModel"
mongoose = require "mongoose"
async = require "async"

auth = require "../helpers/_auth"
helper = require "../helpers/_controller_helper"

# Get User By ID
exports.get_user = (req, res, next) ->
  # This only needs to validate the loudr header
  # Because only the loudr site should be able to access this
  return res.send(401) unless auth.auth_loudr_header req.headers.authorization

  User.findById req.params.id, (err, user) ->
    return res.send helper.fail err if err?

    res.send helper.success 'user', user

# Get All Users
exports.get_all_users = (req, res, next) ->
  # This only needs to validate the loudr header
  # Because only the loudr site should be able to access this
  return res.send(401) unless auth.auth_loudr_header req.headers.authorization

  User.find {}, (err, users) ->
    return res.send helper.fail err if err?

    res.send helper.success 'users', users


# Will return a user object
exports.login = (req, res, next) ->
  # This only needs to validate the loudr header
  # Because only the loudr site should be able to access this
  return res.send(401) unless auth.auth_loudr_header req.headers.authorization

  # With email and password, validate user
  User.getAuthenticated req.body.email, req.body.password, (err, user, reason_id) ->
    # Sever error, this should never happen
    return res.send helper.fail err if err?

    # If successful user, set session, return json object
    if user?
      return res.send helper.success 'user', user.toJson()
    
    # Unsuccessful login because...
    # Defaults to reasons.MAX_ATTEMPTS
    json = helper.fail 'Account is locked, check your email to reactivate your account.'

    # Switch by reason_id
    switch reason_id
      when User.failedLogin.NOT_FOUND
        json = helper.fail 'We do not seem to have that email address.'
      when User.failedLogin.PASSWORD_INCORRECT
        json = helper.fail 'Password was invalid.'

    res.send json

exports.update_user = (req, res, next) ->
  # This only needs to validate the loudr header
  # Because only the loudr site should be able to access this
  return res.send(401) unless auth.auth_loudr_header req.headers.authorization

  User.findById req.params.id, (err, user) ->
    return res.send helper.fail err if err?
    
    # Start checking what has changed
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
        return res.send helper.fail err if err

        return res.send helper.success user

# Create new user, if successful, log them in
exports.create_user = (req, res, next) ->
  # This only needs to validate the loudr header
  # Because only the loudr site should be able to access this
  return res.send(401) unless auth.auth_loudr_header req.headers.authorization
  
  name = {}

  if req.body.full_name?
    name.full = req.body.full_name
  else
    name.first = req.body.first_name
    name.last = req.body.last_name

  new_user = new User
    email: req.body.email
    name: name
    password: req.body.password
 
  # save user to database
  new_user.save (err, user) ->
    return res.send helper.fail err if err

    res.send helper.success 'user', user


exports.delete_user = (req, res, next) ->
  # This only needs to validate the loudr header
  # Because only the loudr site should be able to access this
  return res.send(401) unless auth.auth_loudr_header req.headers.authorization

  User.removeById req.params.id, (err, success) ->
    res.send
      success: !err