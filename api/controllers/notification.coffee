Fan = require "../models/fansModel"
Notification = require "../models/notificationsModel"
mongoose = require "mongoose"
async = require "async"

exports.get_all = (req, res, next) ->
  res.send 'hello'

exports.get_by_id = (req, res, next) ->
  res.send 'hello'

exports.create_notification = (req, res, next) ->
  res.send 'hello'

exports.update_notification = (req, res, next) ->
  res.send 'hello'

exports.delete_notification = (req, res, next) ->
  res.send 'hello'