Fan = require "../models/fansModel"
mongoose = require "mongoose"
async = require "async"

_ = require "../helpers/underscore"
helper = require "../helpers/_controller_helper"

# Get All Fans of an API
exports.get_all_fans = (req, res, next) ->
  q = Fan.find 
    project_id: req.params.project_id

  if req.query.limit?
    q.limit(req.query.limit)
  
  q.execFind (err, fans) ->
    return res.send helper.fail err if err?

    res.send helper.success 'fans', fans

# Get Fan By ID or Email
exports.get_fan = (req, res, next) ->
  Fan.findByIdOrEmail req.params.project_id, req.params.fan_handle, (err, fan) ->
    return res.send helper.fail err if err?

    res.send helper.success 'fan', fan

# Update Fan By Email
exports.update_fan = (req, res, next) ->
  Fan.findByIdOrEmail req.params.project_id, req.params.fan_handle, (err, fan) ->
    return res.send helper.fail err if err

    if req.body.groups?
      fan.groups = _.union fan.groups, req.body.groups
      # Remove unique params
      _.uniq fan.groups

    if req.body.remove_groups?
      fan.groups = _.difference fan.groups, req.body.remove_groups

    if req.body.full_name?
      fan.set('name.full', req.body.full_name)
    else
      fan.name.first = req.body.first_name if req.body.first_name?
      fan.name.last = req.body.last_name if req.body.last_name?
    
    fan.info.registered = req.body.registered_date if req.body.registered_date?

    fan.save (err, fan) ->
      return res.send helper.fail err if err?
      
      res.send helper.success 'fan', fan

# Create Fan
exports.create_fan = (req, res, next) ->
  fan_groups = if req.body.groups? then req.body.groups else []

  new_fan = new Fan
    project_id: req.body.project_id
    email:  req.body.email
    notifications: []
    groups: fan_groups
    info:
      registered: if req.body.registered_date? then req.body.registered_date else Date.now()

  if req.body.full_name?
    new_fan.set('name.full', req.body.full_name)
  else
    new_fan.name.first = req.body.first_name if req.body.first_name?
    new_fan.name.last = req.body.last_name if req.body.last_name?

  new_fan.save (err, fan) ->
    return res.send helper.fail err if err?      
    res.send helper.success 'fan', fan

# Delete Fan By ID
exports.delete_fan = (req, res, next) ->
  Fan.findByIdOrEmail req.params.project_id, req.params.fan_handle, (err, fan) ->
    return res.send helper.fail err if err?

    fan.remove()
    res.send
      success: true