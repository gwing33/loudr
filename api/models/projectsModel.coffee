mongoose = require("mongoose")

Schema = mongoose.Schema
ObjectId = Schema.ObjectId

# Named them fans to avoid something like having "users" and "project users" confusion
ProjectSchema = new Schema(
  name:
    type: String

  users: [
    user_id: ObjectId
    permission:
      type: Number
      default: 0
  ]

  api:
    is_secure:
      type: Boolean
      default: false
    key:
      type: String
      required: true
      index:
        unique: true

  disabled:
    type: Boolean
    default: false

  info:
    creator: ObjectId
    created:
      type: Date
      default: Date.now

    updated:
      type: Date
      default: Date.now
)

ProjectSchema.pre 'save', (next) ->
  project = this
  project.info.updated = Date.now
  next()

ProjectSchema.methods.compareKeys = (api_key) ->
  # loudr username:project.api.key
  return @api.key == api_key

ProjectSchema.methods.toJson = () ->
  project_obj =
    _id: @_id
    name: @name
    api:
      key: @api.key
    disabled: @disabled
    users: @users
    info: @info

  return project_obj

ProjectSchema.methods.authed_user = (user_id, permission_level) ->
  authed = false

  # If they are the creator, they are good
  authed = @info.creator.toString() == user_id
  
  # TODO: IF super user, they are good

  # Look at valid users
  unless authed
    for user in @users
      if user.user_id.toString() == user_id
        authed = true
        break;

  return authed

ProjectSchema.statics.permissions =
  BASIC: 0
  MODERATOR: 1
  ADMIN: 2

ProjectSchema.statics.generateApiKey = (user_id) ->
  crypto = require('crypto')

  return crypto.createHash('sha256').update(Date.now().toString()).update(user_id.toString()).digest('hex')

ProjectSchema.statics.getAll = (user_id, cb) ->
  @find
    'users.user_id': user_id
  , (err, projects) ->
    return cb err if err
    return cb 'Not Found', null unless projects

    cb null, projects

module.exports = mongoose.model('Project', ProjectSchema)