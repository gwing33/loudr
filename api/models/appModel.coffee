mongoose = require("mongoose")

Schema = mongoose.Schema
ObjectId = Schema.ObjectId

# Named them fans to avoid something like having "users" and "application users" confusion
AppSchema = new Schema(
  name:
    type: String

  users: [
    user_id: ObjectId
    permission:
      type: Number
      default: 0
  ]

  api_key:
    type: String
    required: true
    index:
      unique: true

  info:
    creator: ObjectId
    created:
      type: Date
      default: Date.now

    updated:
      type: Date
      default: Date.now
)

AppSchema.statics.permissions = 
  BASIC: 0
  MODERATOR: 1
  ADMIN: 2

module.exports = mongoose.model('App', AppSchema)