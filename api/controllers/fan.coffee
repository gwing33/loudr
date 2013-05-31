Fan = require "../models/fansModel"
mongoose = require "mongoose"
async = require "async"

helper = require "../helpers/_controller_helper"

exports.get_all_fans = (req, res, next) ->
  res.send 'hello'

exports.get_fan_by_email = (req, res, next) ->
  res.send 'hello'

exports.update_fan = (req, res, next) ->
  res.send 'hello'

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
  res.send 'hello'