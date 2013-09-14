Fan = require "../models/fansModel"
mongoose = require "mongoose"
async = require "async"

_ = require "../helpers/underscore"
auth = require "../helpers/_auth"
helper = require "../helpers/_controller_helper"

# Get All Fans of an API
exports.get_all_fans = (req, res, next) ->
  async.parallel
    auth: (cb) ->
      auth.validateRequest req.headers, { project_id: req.params.project_id }, cb
    fans: (cb) ->
      Fan.find
        id: req.params.project_id
        , (err, fans) ->
          cb err, fans
  , (err, results) ->
    return res.send(401) unless results.auth?
    return res.send helper.fail err if err?

    res.send helper.success 'fans', results.fans

# Get Fan By ID or Email
exports.get_fan = (req, res, next) ->
  async.parallel
    auth: (cb) ->
      auth.validateRequest req.headers, { project_id: req.params.project_id }, cb
    fan: (cb) ->
      Fan.findByIdOrEmail req.params.project_id, req.params.fan_handle, (err, fan) ->
        cb err, fan
  , (err, results) ->
    return res.send(401) unless results.auth?
    return res.send helper.fail err if err?

    res.send helper.success 'fan', results.fan

# Update Fan By Email
exports.update_fan = (req, res, next) ->
  async.parallel
    auth: (cb) ->
      auth.validateRequest req.headers, { project_id: req.params.project_id }, cb
    fan: (cb) ->
      Fan.findByIdOrEmail req.params.project_id, req.params.fan_handle, (err, fan) ->
        return res.send helper.fail err if err

        if req.body.groups?
          fan.groups = _.union fan.groups, req.body.groups
          # Remove unique params
          _.uniq fan.groups

        if req.body.remove_groups?
          fan.groups = _.difference fan.groups, req.body.remove_groups

        fan.name.first = req.body.first_name if req.body.first_name?
        fan.name.last = req.body.last_name if req.body.last_name?
        fan.info.registered = req.body.registered_date if req.body.registered_date?
        
        cb null, fan
  , (err, results) ->
    return res.send(401) unless results.auth?
    return res.send helper.fail err if err?

    results.fan.save (err, fan) ->
      return res.send helper.fail err if err?
      
      res.send helper.success 'fan', fan

# Create Fan
exports.create_fan = (req, res, next) ->
  async.parallel
    auth: (cb) ->
      auth.validateRequest req.headers, { project_id: req.params.project_id }, cb
    fan: (cb) ->
      fan_groups = if req.body.groups? then req.body.groups else []

      new_fan = new Fan
        project_id: req.body.project_id
        email:  req.body.email
        name:
          first: if req.body.first_name? then req.body.first_name else ''
          last: if req.body.last_name? then req.body.last_name else ''
        notifications: []
        groups: fan_groups
        info:
          registered: if req.body.registered_date? then req.body.registered_date else Date.now()

      cb null, new_fan
  , (err, results) ->
    return res.send(401) unless results.auth?
    return res.send helper.fail err if err?

    results.fan.save (err, fan) ->
      return res.send helper.fail err if err?      
      res.send helper.success 'fan', fan

# Delete Fan By ID
exports.delete_fan = (req, res, next) ->
  async.parallel
    auth: (cb) ->
      auth.validateRequest req.headers, { project_id: req.params.project_id }, cb
    fan: (cb) ->
      Fan.findByIdOrEmail req.params.project_id, req.params.fan_handle, (err, fan) ->
        cb err, fan
  , (err, results) ->
    return res.send(401) unless results.auth?
    return res.send helper.fail err if err?

    results.fan.remove()
    res.send
      success: true