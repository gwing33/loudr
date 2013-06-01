mongoose = require "mongoose"
async = require "async"

Fan = require "../models/fansModel"
NotificationSchema = require "../models/notificationsSchema"
Notification = mongoose.model 'Notification', NotificationSchema.model

helper = require "../helpers/_controller_helper"

exports.get_all = (req, res, next) ->
  
  res.send 'hello'

exports.get_by_id = (req, res, next) ->
  res.send 'hello'

exports.create_notification = (req, res, next) ->
  new_notification = new Notification

  new_notification.html = req.body.html if req.body.html?
  new_notification.text = req.body.text if req.body.text?
  new_notification.url = req.body.url if req.body.url?
  new_notification.kind = req.body.kind if req.body.kind?
  new_notification.format = req.body.format if req.body.format?

  Fan.getByKeyAndEmail req.params.key, req.params.email, (err, fan) ->
    if err
      res.send
        success: false
        error: err

    fan.notifications.push new_notification

    fan.save (err, fan) ->
      return res.send helper.fail(err) if err

      return res.send helper.success 'notification', new_notification.toJson()

exports.update_notification = (req, res, next) ->
  
  res.send 'hello'

exports.delete_notification = (req, res, next) ->
  
  res.send 'hello'