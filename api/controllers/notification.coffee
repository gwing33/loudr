Project = require "../models/projectsModel"
Fan = require "../models/fansModel"
NotificationSchema = require "../models/notificationsSchema"
mongoose = require "mongoose"
async = require "async"
auth = require "../helpers/_auth"
helper = require "../helpers/_controller_helper"

Notification = mongoose.model 'Notification', NotificationSchema.model



### 
  Fan Notifications via Script Call
###
exports.unsecure_all_notes = (req, res, next) ->
  async.parallel
    auth: (cb) ->
      Project.findById req.params.project_id, (err, project) ->
        console.log project.api.is_secure
        cb err, project? and project.api? and !project.api.is_secure
    fan: (cb) ->
      Fan.findByIdOrEmail req.params.project_id, req.params.fan_handle, (err, fan) ->
        cb err, fan
  , (err, results) ->
    console.log results.auth
    return res.send(401) unless results.auth
    get_all_notes_or_create err, results.fan, req, res, next

exports.secure_all_notes = (req, res, next) ->
  req.headers.authorization = 'Loudr:' + req.params.hash
  req.headers.date = req.params.date

  async.parallel
    auth: (cb) ->
      auth.validateRequest req.headers, { project_id: req.params.project_id }, cb
    fan: (cb) ->
      Fan.findByIdOrEmail req.params.project_id, req.params.fan_handle, (err, fan) ->
        cb err, fan
  , (err, results) ->
    return res.send(401) unless results.auth
    get_all_notes_or_create err, results.fan, req, res, next

get_all_notes_or_create = (err, fan, req, res, next) ->
  if err is "Not Found"
    fan_groups = if req.query.groups? then req.query.groups.split(',') else []

    new_fan = new Fan
      project_id: req.params.project_id
      email:  req.params.fan_handle
      notifications: []
      groups: fan_groups
      info:
        registered: new Date

    new_fan.save (err, fan) ->
      return res.send 403, helper.fail err if err?
      
      if req.query.callback?
        return res.jsonp helper.success 'notifications', new_fan.notifications
      else
        return res.send helper.success 'notifications', new_fan.notifications
  else
    return res.send 403, helper.fail err if err?

    limit = if req.query.limit? then req.query.limit else 10
    page = if req.query.page? then req.query.page else 1

    start_range = (page-1) * limit
    end_range = page * limit

    # Fix ranges if they are over exposed
    start_range = 0 if start_range < 0
    end_range = fan.notifications.length if end_range > fan.notifications.length

    if req.query.callback?
      res.jsonp helper.success 'notifications', fan.notifications.splice start_range, end_range
    else
      res.send helper.success 'notifications', fan.notifications.splice start_range, end_range





###
  Normal API Calls
###

# Get all Notifications
exports.get_all_notes = (req, res, next) ->
  async.parallel
    auth: (cb) ->
      auth.validateRequest req.headers, { project_id: req.params.project_id }, cb
    fan: (cb) ->
      Fan.findByIdOrEmail req.params.project_id, req.params.fan_handle, (err, fan) ->
        cb err, fan
  , (err, results) ->
    return res.send(401) unless results.auth
    return res.send 403, helper.fail err if err?

    limit = if req.query.limit? then req.query.limit else 10
    page = if req.query.page? then req.query.page else 1

    start_range = (page-1) * limit
    end_range = page * limit

    # Fix ranges if they are over exposed
    start_range = 0 if start_range < 0
    end_range = results.fan.notifications.length if end_range > results.fan.notifications.length

    res.send helper.success 'notifications', results.fan.notifications.splice start_range, end_range

# Get Notification by ID
exports.get_note = (req, res, next) ->
  async.parallel
    auth: (cb) ->
      auth.validateRequest req.headers, { project_id: req.params.project_id }, cb
    fan: (cb) ->
      Fan.findByIdOrEmail req.params.project_id, req.params.fan_handle, (err, fan) ->
        cb err, fan
  , (err, results) ->
    return res.send(401) unless results.auth
    return res.send 403, helper.fail err if err?

    notification = results.fan.notifications.id req.params.id
    
    return res.send helper.fail 'Not Found' unless notification
    res.send helper.success 'notification', notification

# Create Notification
exports.create_note = (req, res, next) ->
  async.parallel
    auth: (cb) ->
      auth.validateRequest req.headers, { project_id: req.params.project_id }, cb
    fan: (cb) ->
      Fan.findByIdOrEmail req.params.project_id, req.params.fan_handle, (err, fan) ->
        cb err, fan
  , (err, results) ->
    return res.send(401) unless results.auth
    return res.send 403, helper.fail err if err?

    new_notification = new Notification

    if req.body.html?
      new_notification.html = req.body.html
      new_notification.format = Notification.formats.HTML
    else if req.body.text?
      new_notification.text = req.body.text
      new_notification.format = Notification.formats.TEXT
    else if !req.body.url?
      res.send 403, helper.fail('Note must have HTML, Text or a URL.')

    new_notification.url = req.body.url if req.body.url?
    new_notification.kind = req.body.kind if req.body.kind?
    new_notification.format = req.body.format if req.body.format?

    results.fan.notifications.push new_notification

    results.fan.save (err, fan) ->
      return res.send helper.fail err if err

      res.send helper.success 'notification', new_notification

# Update Notification
exports.update_note = (req, res, next) ->
  async.parallel
    auth: (cb) ->
      auth.validateRequest req.headers, { project_id: req.params.project_id }, cb
    fan: (cb) ->
      Fan.findByIdOrEmail req.params.project_id, req.params.fan_handle, (err, fan) ->
        cb err, fan
  , (err, results) ->
    return res.send(401) unless results.auth
    return res.send 403, helper.fail err if err?
    
    notification = results.fan.notifications.id(req.params.id)

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

    results.fan.save (err, fan) ->
      return res.send helper.fail err if err

      res.send helper.success 'notification', notification

# Delete Notification
exports.delete_note = (req, res, next) ->
  async.parallel
    auth: (cb) ->
      auth.validateRequest req.headers, { project_id: req.params.project_id }, cb
    fan: (cb) ->
      Fan.findByIdOrEmail req.params.project_id, req.params.fan_handle, (err, fan) ->
        cb err, fan
  , (err, results) ->
    return res.send(401) unless results.auth
    return res.send 403, helper.fail err if err?
    
    results.fan.notifications.pull
      _id: req.params.id

    results.fan.save (err, fan) ->
      res.send
        success: !err