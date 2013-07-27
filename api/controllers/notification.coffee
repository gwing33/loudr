mongoose = require "mongoose"
async = require "async"

Fan = require "../models/fansModel"
NotificationSchema = require "../models/notificationsSchema"
Notification = mongoose.model 'Notification', NotificationSchema.model

helper = require "../helpers/_controller_helper"

exports.get_all = (req, res, next) ->
  Fan.getByKeyAndEmail req.params.key, req.params.email, (err, fan) ->
    if err and err is not 'Not Found'
      return res.send
        success: false
        error: err

    if err is 'Not Found'
      # Create Fan
      fan_groups = if req.body.groups? then req.body.groups else []

      new_fan = new Fan
        api:
          key: req.params.key
        email:  req.params.email
        notifications: []
        info:
          registered: new Date

      new_fan.save (err, fan) ->
        if err
          return res.send
            success: false
            error: err

        if req.query.callbalck?
          res.jsonp fan.notifications
        else
          res.send fan.notifications
    else
      if req.query.callback?
        res.jsonp fan.notifications
      else
        res.send fan.notifications

exports.get_by_id = (req, res, next) ->
  Fan.getByKeyAndEmail req.params.key, req.params.email, (err, fan) ->
    if err
      return res.send
        success: false
        error: err
    
    notification = fan.notifications.id(req.params.id)

    return res.send helper.fail 'Not Found' unless notification
    return res.send helper.success 'notification', notification.toJson()
  

exports.create_notification = (req, res, next) ->
  new_notification = new Notification

  new_notification.html = req.body.html if req.body.html?
  new_notification.text = req.body.text if req.body.text?
  new_notification.url = req.body.url if req.body.url?
  new_notification.kind = req.body.kind if req.body.kind?
  new_notification.format = req.body.format if req.body.format?

  Fan.getByKeyAndEmail req.params.key, req.params.email, (err, fan) ->
    if err
      return res.send
        success: false
        error: err

    fan.notifications.push new_notification

    fan.save (err, fan) ->
      return res.send helper.fail(err) if err

      return res.send helper.success 'notification', new_notification.toJson()

exports.update_notification = (req, res, next) ->
  Fan.getByKeyAndEmail req.params.key, req.params.email, (err, fan) ->
    if err
      return res.send
        success: false
        error: err
    
    notification = fan.notifications.id(req.params.id)

    return res.send helper.fail 'Not Found' unless notification

    notification.html = req.body.html if req.body.html?
    notification.text = req.body.text if req.body.text?
    notification.url = req.body.url if req.body.url?
    notification.kind = req.body.kind if req.body.kind?
    notification.format = req.body.format if req.body.format?
    notification.seen = req.body.seen if req.body.seen?
    notification.interacted = req.body.interacted if req.body.interacted?
    notification.dissmissed = req.body.dissmissed if req.body.dissmissed?
    notification.updated = Date.now()

    fan.save (err, fan) ->
      return res.send helper.fail(err) if err

      return res.send helper.success 'notification', notification.toJson()

exports.delete_notification = (req, res, next) ->
  Fan.getByKeyAndEmail req.params.key, req.params.email, (err, fan) ->
    if err
      return res.send
        success: false
        error: err
    
    notification = fan.notifications.id(req.params.id).remove()

    return res.send helper.fail 'Not Found' unless notification

    fan.save (err, fan) ->
      return res.send { success: !err }