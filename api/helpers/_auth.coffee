Project = require "../models/projectsModel"
helper = require "./_controller_helper"
async = require "async"

Auth = {}
# Validate the Header, regular or loudr
Auth.auth_header = (header) ->
  return false unless header?
  return true if Auth.auth_loudr_header header
  
  return header.indexOf("Loudr :") != -1

# Validate just the Admin Loudr Header
Auth.auth_loudr_header = (header) ->
  return false unless header?
  return header.indexOf("Loudr asdf:") != -1

# Validates both Header and API Key
Auth.auth_header_key = (header, cb) ->
  valid_header = Auth.auth_header header
  return cb null, false unless valid_header
  Auth.valid_api_key header, cb

# Validate both Loudr Header and API Key
Auth.auth_loudr_header_key = (header, cb) ->
  valid_header = Auth.auth_loudr_header header
  return cb null, false unless valid_header
  Auth.valid_api_key header, cb

# Validates just API Key
Auth.valid_api_key = (token, cb) ->
  key = token
  if token.indexOf(":") is not -1
    key = Auth.get_api_key token

  Project.find
    api:
      key: key
    , (err, projects) ->
      cb null, false if err?
      cb null, projects.length is 1

# Returns Just the API Key portion of the token
Auth.get_api_key = (token) ->
  tokens = token.split ':'
  return tokens[1]

module.exports = Auth