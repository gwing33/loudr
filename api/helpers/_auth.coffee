Project = require "../models/projectsModel"
helper = require "./_controller_helper"
async = require "async"
crypto = require 'crypto'

# New Setup
# User has Project API Secret Key
# Email is required, so always hash with email
# Also add in the timestamp
#
# I.E. hash = crypto.createHmac('sha256',api.key).update(email).update(date.now()).digest('hex')
# 
# If hash === provided_hash, then valid request

Auth = {}
used_loudr_header = false

# Validate the Request.
# Make sure it was specified for Loudr usage
# Get the Auth Hash out and validate it against the project
#
# options is an object that can accept different values
#   loudr_only = bool
#   project_id = ID
Auth.validateRequest = (headers, options, cb) ->
  options.loudr_only = false unless options.loudr_only?

  # Validate auth token
  return cb('Not Authorized', null) unless Auth.validateAuthToken headers.authorization, options.loudr_only

  # If it is loudr authorized and there is no project ID, proceed.
  # The idea behind this:
  # You'd have to know the special loudr auth token in order to access this
  if used_loudr_header and !options.project_id?
    return cb(null, true)

  # Parse out the Auth Token passed in
  token = Auth.getToken headers.authorization

  # Find the project so I can validate the api key against it.
  Project.findById options.project_id, (err, project) ->
    return cb(err, null) if err?
    
    hashed_key = project.api.key

    # If it's a Loudr header and the token === the api key, return successfully
    if options.loudr_only and token is hashed_key
      return cb(null, project)

    # If it's set up as secure then I want to hash the api key
    if project.api.is_secure
      hashed_key = Auth.hashKey project.api.key, headers.Date
    
    if token is hashed_key
      return cb(null, project)
    else
      return cb("Not Authorized", null)

# Returns the hashed secret key
Auth.getToken = (token) ->
  tokens = token.split ':'
  return tokens[1]

# Validates the authorization header is for Loudr
Auth.validateAuthToken = (authorization, loudr_only) ->
  return false unless authorization?
  
  if loudr_only
    return Auth.validateInternalAuthToken authorization
  else
    return authorization.indexOf("Loudr:") != -1 or Auth.validateInternalAuthToken authorization

# Validates the authorization for internal use only
Auth.validateInternalAuthToken = (authorization) ->
  used_loudr_header = authorization.indexOf("Loudr asdf:") != -1
  return used_loudr_header

# Hash the key and update it with the date
Auth.hashKey = (key, header_date) ->
  key_hash = crypto.createHmac('sha256', key)

  if header_date?
    key_hash.update header_date

  return key_hash.digest('hex')

###
# Validate the Header, regular or loudr
Auth.auth_header = (header) ->
  return false unless header?
  
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
  if token.indexOf(":") > -1
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
###
module.exports = Auth