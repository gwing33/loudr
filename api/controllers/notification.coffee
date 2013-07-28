Fan = require "../models/fansModel"
NotificationSchema = require "../models/notificationsSchema"
mongoose = require "mongoose"
async = require "async"

Notification = mongoose.model 'Notification', NotificationSchema.model

auth = require "../helpers/_auth"
helper = require "../helpers/_controller_helper"

# Get all Notifications
exports.get_all_notes = (req, res, next) ->
  # This needs to validate both Header and API Key
  return res.status(401).send() unless auth.auth_header_key req.headers.authorization

  Fan.findById req.params.fan_id, (err, fan) ->
    return res.send helper.fail err if err?

    res.send helper.success 'notes', fan.notifications

exports.get_all_notes_by_email = (req, res, next) ->
  # This needs to validate both Header and API Key
  return res.status(401).send() unless auth.auth_header_key req.headers.authorization

  Fan.findByKeyAndEmail req.params.key, req.params.email, (err, fan) ->
    return res.send helper.fail err if err and err is not 'Not Found'

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
          return res.jsonp fan.notifications
        else
          return res.send fan.notifications
    else
      if req.query.callback?
        return res.jsonp fan.notifications
      else
        return res.send fan.notifications
  
# Get Notification by ID
exports.get_note = (req, res, next) ->
  # This needs to validate both Header and API Key
  return res.status(401).send() unless auth.auth_header_key req.headers.authorization

  Fan.findById req.params.fan_id, (err, fan) ->
    return res.send helper.fail err if err?

    notification = fan.notifications.id req.params.id
    
    return res.send helper.fail 'Not Found' unless notification
    res.send helper.success 'notification', notification

# Get Notification by Email
exports.get_note_by_email = (req, res, next) ->
  # This needs to validate both Header and API Key
  return res.status(401).send() unless auth.auth_header_key req.headers.authorization

  Fan.findByKeyAndEmail req.params.key, req.params.email, (err, fan) ->
    return res.send helper.fail err if err?

    notification = fan.notifications.id req.params.id
    
    return res.send helper.fail 'Not Found' unless notification
    res.send helper.success 'notification', notification

# Create Notification
exports.create_note = (req, res, next) ->
  # This needs to validate both Header and API Key
  return res.status(401).send() unless auth.auth_header_key req.headers.authorization

  new_notification = new Notification

  new_notification.html = req.body.html if req.body.html?
  new_notification.text = req.body.text if req.body.text?
  new_notification.url = req.body.url if req.body.url?
  new_notification.kind = req.body.kind if req.body.kind?
  new_notification.format = req.body.format if req.body.format?

  Fan.findById req.params.fan_id, (err, fan) ->
    return res.send helper.fail err if err?

    fan.notifications.push new_notification

    fan.save (err, fan) ->
      return res.send helper.fail err if err

      res.send helper.success 'notification', new_notification

# Create Notification By Email
exports.create_note_by_email = (req, res, next) ->
  # This needs to validate both Header and API Key
  return res.status(401).send() unless auth.auth_header_key req.headers.authorization

  new_notification = new Notification

  new_notification.html = req.body.html if req.body.html?
  new_notification.text = req.body.text if req.body.text?
  new_notification.url = req.body.url if req.body.url?
  new_notification.kind = req.body.kind if req.body.kind?
  new_notification.format = req.body.format if req.body.format?

  Fan.findByKeyAndEmail req.params.key, req.params.email, (err, fan) ->
    return res.send helper.fail err if err?

    fan.notifications.push new_notification

    fan.save (err, fan) ->
      return res.send helper.fail err if err

      res.send helper.success 'notification', new_notification

# Update Notification
exports.update_note = (req, res, next) ->
  # This needs to validate both Header and API Key
  return res.status(401).send() unless auth.auth_header_key req.headers.authorization

  Fan.findById req.params.fan_id, (err, fan) ->
    return res.send helper.fail err if err?
    
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
      return res.send helper.fail err if err

      res.send helper.success 'notification', notification

# Update Notification
exports.update_note_by_email = (req, res, next) ->
  # This needs to validate both Header and API Key
  return res.status(401).send() unless auth.auth_header_key req.headers.authorization

  Fan.findByKeyAndEmail req.params.key, req.params.email, (err, fan) ->
    return res.send helper.fail err if err?
    
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
      return res.send helper.fail err if err

      res.send helper.success 'notification', notification

# Delete Notification
exports.delete_note = (req, res, next) ->
  # This needs to validate both Header and API Key
  return res.status(401).send() unless auth.auth_header_key req.headers.authorization

  Fan.findById req.params.fan_id, (err, fan) ->
    return res.send helper.fail err if err
    
    notification = fan.notifications.id(req.params.id).remove()

    return res.send helper.fail 'Not Found' unless notification

    fan.save (err, fan) ->
      res.send
        success: !err

# Delete Notification
exports.delete_note_by_email = (req, res, next) ->
  # This needs to validate both Header and API Key
  return res.status(401).send() unless auth.auth_header_key req.headers.authorization

  Fan.findByKeyAndEmail req.params.key, req.params.email, (err, fan) ->
    return res.send helper.fail err if err
    
    notification = fan.notifications.id(req.params.id).remove()

    return res.send helper.fail 'Not Found' unless notification

    fan.save (err, fan) ->
      res.send
        success: !err