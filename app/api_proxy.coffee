config = require "../config"
request = require "request"

exports.api_url = config.settings.api_host + ':' + config.settings.api_port

exports.post = (url, options, cb) ->
  options = @set_auth_token options
  
  request.post @api_url + url, options, cb

exports.get = (url, options, cb) ->
  options = @set_auth_token options
  
  request.get @api_url + url, options, cb

exports.put = (url, options, cb) ->
  options = @set_auth_token options

  request.put @api_url + url, options, cb

exports.del = (url, options, cb) ->
  options = @set_auth_token options

  request.del @api_url + url, options, cb

exports.set_auth_token = (options) ->
  if options.headers is undefined
    options.headers = {}
  options.headers.Authorization = @get_signed_token()

  return options

exports.get_signed_token = () ->
  return 'Loudr asdf:'

#  post_data = 
#    form:
#      email: req.body.email
#      password: req.body.password
#
#  request.post api_url + '/auth/login', post_data, (err, resp, body) ->
#    res.send 'error' if err
#
#    res.send body