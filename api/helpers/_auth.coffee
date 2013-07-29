Project = require "../models/projectsModel"
helper = require "./_controller_helper"
async = require "async"

Auth = {}
# Validate the Header, regular or loudr
Auth.auth_header = (header) ->
  return true if Auth.auth_loudr_header header

  return header.indexOf("Loudr :") != -1

# Validate just the Admin Loudr Header
Auth.auth_loudr_header = (header) ->
  return header.indexOf("Loudr asdf:") != -1

# Validates both Header and API Key
Auth.auth_header_key = (header, cb) ->
  valid_header = Auth.auth_header header
  Auth.valid_api_key header, valid_header, cb

# Validate both Loudr Header and API Key
Auth.auth_loudr_header_key = (header, cb) ->
  valid_header = Auth.auth_loudr_header header
  Auth.valid_api_key header, valid_header, cb

# Validates just API Key
Auth.valid_api_key = (token, is_valid_header, cb) ->
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