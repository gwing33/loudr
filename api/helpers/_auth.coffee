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
  if options.loudr_only and !options.project_id?
    return cb(null, true)

  # Parse out the Auth Token passed in
  token = Auth.getToken headers.authorization

  # Find the project so I can validate the api key against it.
  Project.findById options.project_id, (err, project) ->
    return cb(err, null) if err?
    
    hashed_key = project.api.key

    # If it's a Loudr header and the token === the api key, return successfully
    if used_loudr_header and token is hashed_key
      return cb(null, project)

    # If it's set up as secure then I want to hash the api key
    console.log headers.date, project.api.key
    if project.api.is_secure
      hashed_key = Auth.hashKey project.api.key, headers.date
    console.log token, hashed_key
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
  return false unless header_date?
  key_hash = crypto.createHmac('sha256', key).update(header_date)

  return key_hash.digest('hex')

module.exports = Auth