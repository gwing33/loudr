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
  api:
    key:
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

FanSchema.statics.findByKeyAndEmail = (key, email, cb) ->
  @findOne
    api:
      key: key
    email: email
  , (err, fan) ->
    return cb err if err
    return cb 'Not Found', null unless fan

    cb null, fan

module.exports = mongoose.model('Fan', FanSchema)