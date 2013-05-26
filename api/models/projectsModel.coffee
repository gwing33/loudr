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


ProjectSchema.statics.permissions =
  BASIC: 0
  MODERATOR: 1
  ADMIN: 2

ProjectSchema.statics.generateApiKey = (user_id) ->
  crypto = require('crypto')

  return crypto.createHash('sha256').update(Date.now().toString()).update(user_id).digest('hex')

ProjectSchema.statics.getById = (id, cb) ->
  @findOne
    _id: id
  , (err, user) ->
    return cb err if err
    return cb null, null, reasons.NOT_FOUND unless user

    cb null, user

module.exports = mongoose.model('Project', ProjectSchema)