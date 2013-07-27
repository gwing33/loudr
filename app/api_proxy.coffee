config = require "../config"
request = require "request"

exports.api_url = config.settings.api_host + ':' + config.settings.api_port

exports.post = (url, options, uid, cb) ->
  options = @set_auth_token options, uid
  
  request.post @api_url + url, options, cb

exports.get = (url, options, uid, cb) ->
  options = @set_auth_token options, uid
  
  request.get @api_url + url, options, cb

exports.put = (url, options, uid, cb) ->
  options = @set_auth_token options, uid

  request.put @api_url + url, options, cb

exports.del = (url, options, uid, cb) ->
  options = @set_auth_token options, uid

  request.del @api_url + url, options, cb

exports.set_auth_token = (options, uid) ->
  options.headers = {} unless options.headers?
  options.headers.Authorization = @get_signed_token uid

  return options

exports.get_signed_token = (uid) ->
  # This token should be different from what everyone else uses
  # That way I can restrict access for everyone but this application
  token = 'Loudr asdf:'
  token += uid if uid?
  return token

#  post_data = 
#    form:
#      email: req.body.email
#      password: req.body.password
#
#  request.post api_url + '/auth/login', post_data, (err, resp, body) ->
#    res.send 'error' if err
#
#    res.send body