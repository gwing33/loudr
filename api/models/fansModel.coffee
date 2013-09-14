mongoose = require("mongoose")
NotificationSchema = require("./notificationsSchema")

Schema = mongoose.Schema
ObjectId = Schema.ObjectId

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

  # This is a user entered param
  # This is a string, not an 'ObjectId'
  fan_id:
    type: String

  social:
    facebook:
      type: String
    twitter:
      type: String
    klout:
      type: String

  # Reference to the APP
  project_id:
    type: ObjectId
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

# This will search for a fan by project_id and fan_id or Email
FanSchema.statics.findByIdOrEmail = (project_id, id_or_email, cb) ->

  checkIfIdOrEmail = new RegExp "^[0-9a-fA-F]{24}$"

  options = { project_id: project_id }

  if checkIfIdOrEmail.test id_or_email
    options._id = id_or_email
  else
    options.email = id_or_email

  # Set the Project ID
  @findOne options, (err, fan) ->
    return cb err if err
    return cb 'Not Found', null unless fan

    cb null, fan

module.exports = mongoose.model('Fan', FanSchema)