Fan = require "../models/fansModel"
mongoose = require "mongoose"
async = require "async"

_ = require "../helpers/underscore"
auth = require "../helpers/_auth"
helper = require "../helpers/_controller_helper"


# Get All Fans of an API
exports.get_all_fans = (req, res, next) ->
  # This needs to validate both Header and API Key
  return res.status(401).send() unless auth.auth_header_key req.headers.authorization

  Fan.find 
    api:
      key: req.params.key
    , (err, fans) ->
      return res.send helper.fail err if err?

      res.send helper.success 'fans', fans

# Get Fan By ID
exports.get_fan = (req, res, next) ->
  # This needs to validate both Header and API Key
  return res.status(401).send() unless auth.auth_header_key req.headers.authorization

  Fan.findById req.params.id, (err, fan) ->
    return res.send helper.fail err if err?

    res.send helper.success 'fan', fan

# Get Fan By Email
exports.get_fan_by_email = (req, res, next) ->
  # This needs to validate both Header and API Key
  return res.status(401).send() unless auth.auth_header_key req.headers.authorization

  Fan.findByKeyAndEmail req.params.key, req.params.email, (err, fan) ->
    return res.send helper.fail err if err?

    res.send helper.success 'fan', fan

# Update Fan By ID
exports.update_fan = (req, res, next) ->
  # This needs to validate both Header and API Key
  return res.status(401).send() unless auth.auth_header_key req.headers.authorization

  Fan.findById req.params.id, (err, fan) ->
    return res.send fail(err) if err

    if req.body.groups?
      fan.groups = _.union fan.groups, req.body.groups
      # Remove unique params
      _.uniq fan.groups

    if req.body.remove_groups?
      fan.groups = _.difference fan.groups, req.body.remove_groups

    fan.name.first = req.body.first_name if req.body.first_name?
    fan.name.last = req.body.last_name if req.body.last_name?
    fan.info.registered = req.body.registered_date if req.body.registered_date?
      
    fan.save (err, fan) ->
      return res.send helper.fail err if err
      return res.send helper.success 'fan', fan.toJson()

# Update Fan By Email
exports.update_fan_by_email = (req, res, next) ->
  # This needs to validate both Header and API Key
  return res.status(401).send() unless auth.auth_header_key req.headers.authorization

  Fan.findByKeyAndEmail req.params.key, req.params.email, (err, fan) ->
    return res.send fail(err) if err

    if req.body.groups?
      fan.groups = _.union fan.groups, req.body.groups
      # Remove unique params
      _.uniq fan.groups

    if req.body.remove_groups?
      fan.groups = _.difference fan.groups, req.body.remove_groups

    fan.name.first = req.body.first_name if req.body.first_name?
    fan.name.last = req.body.last_name if req.body.last_name?
    fan.info.registered = req.body.registered_date if req.body.registered_date?
      
    fan.save (err, fan) ->
      return res.send helper.fail err if err
      return res.send helper.success 'fan', fan.toJson()

# Create Fan
exports.create_fan = (req, res, next) ->
  # This needs to validate both Header and API Key
  return res.status(401).send() unless auth.auth_header_key req.headers.authorization

  fan_groups = if req.body.groups? then req.body.groups else []

  new_fan = new Fan
    api:
      key: req.body.api_key # Named api_key to distinquish between url param and body
    email:  req.body.email
    name:
      first: if req.body.first_name? then req.body.first_name else ''
      last: if req.body.last_name? then req.body.last_name else ''
    notifications: []
    groups: fan_groups
    info:
      registered: if req.body.registered_date? then req.body.registered_date else Date.now()

  new_fan.save (err, fan) ->
    return res.send helper.fail err if err

    return res.send helper.success 'fan', fan

# Delete Fan By ID
exports.delete_fan = (req, res, next) ->
  # This needs to validate both Header and API Key
  return res.status(401).send() unless auth.auth_header_key req.headers.authorization

  Fan.removeById req.params.id, (err, success) ->
    res.send
      success: !err