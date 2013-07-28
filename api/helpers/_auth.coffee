Project = require "../models/projectsModel"
helper = require "./_controller_helper"

# Validate the Header, regular or loudr
exports.auth_header = (header) ->
  return true if auth_loudr_header header

  return header.indexOf("Loudr :") != -1

# Validate just the Admin Loudr Header
exports.auth_loudr_header = (header) ->
  return header.indexOf("Loudr asdf:") != -1

# Validates both Header and API Key
exports.auth_header_key = (header) ->
  return auth_header header and valid_api_key header

# Validate both Loudr Header and API Key
exports.auth_loudr_header_key = (header) ->
  return auth_loudr_header header and valid_api_key header

# Validates just API Key
exports.valid_api_key = (auth_token) ->
  key = get_api_key auth_token

  Project.findById
    api:
      key: key
    , (err, project) ->
      return project?

# Returns Just the API Key portion of the token
exports.get_api_key = (auth_token) ->
  tokens = auth_token.split ':'
  return tokens[1]