mongoose = require("mongoose")

Schema = mongoose.Schema
ObjectId = Schema.ObjectId

UserAppPermissions = new Schema(
  user_id: ObjectId
  permission:
    type: Number
    default: 0
)

UserAppPermissions.statics.permissions = 
  BASIC: 0
  MODERATOR: 1
  ADMIN: 2

# Named them fans to avoid something like having "users" and "application users" confusion
AppSchema = new Schema(
  name:
    type: String

  users: [UserAppPermissions]

  info:
    created:
      type: Date
      default: Date.now

    updated:
      type: Date
      default: Date.now
)


module.exports = mongoose.model('App', AppSchema)