User = require "../models/users"
mongoose = require "mongoose"

exports.create = (req, res, next) ->
  res.send "creating user..."

exports.get_by_email = (req, res, next) ->
  res.send "getting user: " + req.params.email

exports.login = (req, res, next) ->
  params = JSON.parse req.body

  User.getAuthenticated params.email, params.password, (err, user, reason) ->
    throw err  if err
    
    if user
      console.log "login success"
      res.send "Wee, welcome " + params.email
      return
    
    res.send "error: " + reason

    # reasons = User.failedLogin
    # switch reason
    #   when reasons.NOT_FOUND, reasons.PASSWORD_INCORRECT
    #   when reasons.MAX_ATTEMPTS