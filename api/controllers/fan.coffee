Fan = require "../models/fansModel"
mongoose = require "mongoose"
async = require "async"

_ = require "../helpers/underscore"
helper = require "../helpers/_controller_helper"

exports.get_all_fans = (req, res, next) ->
  # TODO
  res.send 'hello'

exports.get_fan_by_email = (req, res, next) ->
  Fan.getByKeyAndEmail req.params.key, req.params.email, (err, fan) ->
    if err
      res.send
        success: false
        error: err

    tmp_fan = fan.toJson()
    tmp_fan.success = true

    return res.send tmp_fan

exports.update_fan = (req, res, next) ->
  Fan.getByKeyAndEmail req.params.key, req.params.email, (err, fan) ->
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
      return res.send helper.fail(err) if err
      return res.send helper.success 'fan', fan.toJson()

exports.create_fan = (req, res, next) ->
  fan_groups = if req.body.groups? then req.body.groups else []
  
  registered_date = Date.now

  new_fan = new Fan
    api_key: req.params.key
    email:  req.body.email
    name:
      first: if req.body.first_name? then req.body.first_name else ''
      last: if req.body.last_name? then req.body.last_name else ''
    groups: fan_groups
    info:
      registered: if req.body.registered_date? then req.body.registered_date else Date.now

  new_fan.save (err, fan) ->
    return res.send helper.fail(err) if err

    return res.send helper.success 'fan', fan.toJson()

exports.delete_fan = (req, res, next) ->
  Fan.removeFan req.params.key, req.params.email, (err, success) ->
    return res.send { success: !err }