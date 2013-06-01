mongoose = require("mongoose")
NotificationSchema = require("./notificationsSchema")

Schema = mongoose.Schema

# Named them fans to avoid something like having "users" and "application users" confusion
FanSchema = new Schema(
  name:
    first:
      type: String
    last:
      type: String
  
  email:
    type: String
    required: true

  social:
    facebook:
      type: String
    twitter:
      type: String
    klout:
      type: String

  # Reference to the APP
  api_key:
    type: String
    required: true

  notifications: [NotificationSchema.model]

  groups: [String]
 
  info:
    # This is the date they signed up for the project
    # It is not when a user sent the information over to us
    registered:
      type: Date
      default: Date.now

    created:
      type: Date
      default: Date.now

    updated:
      type: Date
      default: Date.now
)

FanSchema.methods.toJson = () ->
  fan_obj =
    _id: @_id
    name: @name.full
    email: @email
    social: @social
    api_key: @api_key
    notifications: @notifications
    groups: @groups
    info: @info

  return fan_obj

FanSchema.virtual('name.full').get(() ->
    return @.name.first + ' ' + @.name.last
  ).set (name) ->
    split = name.split(' ')
    @.name.first = split[0]
    
    if split.length > 2
      split.splice 0, 1
      @.name.last = split.join(' ')
    else
      @.name.last = split[1]

FanSchema.statics.removeFan = (key, email, cb) ->
  # ToDo Add some sort of Permissions here.
  @findOne
    api_key: key
    email: email
  , (err, fan) ->
    return cb err if err
    return cb 'Not Found', null unless fan
    
    fan.remove()
    cb null, true

FanSchema.statics.getByKeyAndEmail = (key, email, cb) ->
  @findOne
    api_key: key
    email: email
  , (err, fan) ->
    return cb err if err
    return cb 'Not Found', null unless fan

    cb null, fan


module.exports = mongoose.model('Fan', FanSchema)