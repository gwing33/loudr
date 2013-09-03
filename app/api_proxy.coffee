config = require "../config"
request = require "request"

exports.api_url = config.settings.api_protocol + config.settings.api_host + ':' + config.settings.api_port

exports.post = (url, options, api_key, cb) ->
  console.log @api_url
  options = @set_loudr_auth_token options, api_key
  
  request.post @api_url + url, options, cb

exports.get = (url, options, api_key, cb) ->
  options = @set_loudr_auth_token options, api_key
  
  request.get @api_url + url, options, cb

exports.put = (url, options, api_key, cb) ->
  options = @set_loudr_auth_token options, api_key

  request.put @api_url + url, options, cb

exports.del = (url, options, api_key, cb) ->
  options = @set_loudr_auth_token options, api_key

  request.del @api_url + url, options, cb

exports.set_loudr_auth_token = (options, api_key) ->
  options.headers = {} unless options.headers?
  options.headers.Authorization = @get_loudr_signed_token api_key

  return options

exports.get_loudr_signed_token = (api_key) ->
  # This token should be different from what everyone else uses
  # That way I can restrict access for everyone but this application
  token = 'Loudr asdf:'
  token += api_key unless api_key
  return token



###
  These are non loudr signed tokens.
###
exports.unsigned_post = (url, options, api_key, cb) ->
  options = @set_auth_token options, api_key
  
  request.post @api_url + url, options, cb

exports.unsigned_get = (url, options, api_key, cb) ->
  options = @set_auth_token options, api_key
  
  request.get @api_url + url, options, cb

exports.unsigned_put = (url, options, api_key, cb) ->
  options = @set_auth_token options, api_key

  request.put @api_url + url, options, cb

exports.unsigned_del = (url, options, api_key, cb) ->
  options = @set_auth_token options, api_key

  request.del @api_url + url, options, cb

exports.set_auth_token = (options, api_key) ->
  options.headers = {} unless options.headers?
  options.headers.Authorization = @get_signed_token api_key

  return options

exports.get_signed_token = (api_key) ->
  # This token should be different from what everyone else uses
  # That way I can restrict access for everyone but this application
  token = 'Loudr :'
  token += api_key if api_key?
  return token