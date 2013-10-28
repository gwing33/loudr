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
# OLD: Auth.validateRequest = (headers, options, cb) ->
Auth.loudrValidateReq = (req, res, next) ->
  # Validate auth token
  return res.send(401)  unless Auth.validateAuthToken req.headers.authorization, true
  
  next()


Auth.validateRequest = (req, res, next) ->
  # Validate auth token
  return res.send(401)  unless Auth.validateAuthToken req.headers.authorization, false

  Auth.finishValidation req, res, next

Auth.finishValidation = (req, res, next) ->
  # Parse out the Auth Token passed in
  token = Auth.getToken req.headers.authorization

  project_id = req.params.id
  project_id = req.params.project_id  if req.params.project_id?

  # Find the project so I can validate the api key against it.
  Project.findById project_id, (err, project) ->
    # console.log err, project
    return res.send(401)  if err?
    return res.send(404)  unless project?
    
    req.project = project
    hashed_key = project.api.key

    # If it's a Loudr header and the token === the api key, return successfully
    if used_loudr_header and token is hashed_key
      return next()

    # If it's set up as secure then I want to hash the api key
    if project.api.is_secure
      hashed_key = Auth.hashKey project.api.key, req.headers.date

    if token is hashed_key
      return next()

    return res.send(401)


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