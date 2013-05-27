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
  new_fan = new Fan
    api_key: ''
    email: ''
    name:
      first: ''
      last: ''
    social:
      facebook: ''
      twitter: ''
      klout: ''
    groups: ''
    info:
      registered: ''

    new_fan.save (err, fan) ->
      return res.send helper.fail(err) if err

      return res.send helper.success fan.toJson()

exports.delete_fan = (req, res, next) ->
  res.send 'hello'