Project = require "../models/projectsModel"
helper = require "./_controller_helper"

Auth = {}
# Validate the Header, regular or loudr
Auth.auth_header = (header) ->
  return true if Auth.auth_loudr_header header

  return header.indexOf("Loudr :") != -1

# Validate just the Admin Loudr Header
Auth.auth_loudr_header = (header) ->
  return header.indexOf("Loudr asdf:") != -1

# Validates both Header and API Key
Auth.auth_header_key = (header) ->
  valid_key = Auth.valid_api_key header
  valid_header = Auth.auth_header header
  return  valid_key and valid_header

# Validate both Loudr Header and API Key
Auth.auth_loudr_header_key = (header) ->
  valid_key = Auth.valid_api_key header
  valid_header = Auth.auth_loudr_header header
  return  valid_key and valid_header

# Validates just API Key
Auth.valid_api_key = (token) ->
  key = Auth.get_api_key token

  Project.findById
    api:
      key: key
    , (err, project) ->
      return project?

# Returns Just the API Key portion of the token
Auth.get_api_key = (token) ->
  tokens = token.split ':'
  return tokens[1]

module.exports = Auth