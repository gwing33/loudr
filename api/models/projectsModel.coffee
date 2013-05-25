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

ProjectSchema.statics.getById = (id, cb) ->
  @findOne
    _id: id
  , (err, user) ->
    return cb err if err
    return cb null, null, reasons.NOT_FOUND unless user

    cb null, user

ProjectSchema.methods.generateApiKey = (app_id, user_password) ->
  crypto = require('crypto')

  api_key = crypto.createHash('sha256').update(app_id).update(user_password).digest('hex')
  console.log api_key

  @.set('api.key', api_key)

ProjectSchema.methods.compareKeys = (api_key) ->
  # loudr username:project.api.key
  return @api.key == api_key

ProjectSchema.methods.toJson = () ->
  project_obj =
    _id: @._id
    users: @.users
    info: @.info

  return project_obj



ProjectSchema.statics.permissions =
  BASIC: 0
  MODERATOR: 1
  FULL_CONTROL: 2
  CREATOR: 3

module.exports = mongoose.model('Project', ProjectSchema)