mongoose = require("mongoose")

Schema = mongoose.Schema

NotificationSchema = new Schema(
  html:
    type: String
  text:
    type: String
  url:
    type: String
  kind:
    type: Number
    default: 0

  format:
    type: Number
    default: 0

  seen:
    type: Number
    default: 0

  interacted:
    type: Number
    default: 0

  dissmissed:
    type: Boolean
    default: false

  created:
    type: Date
    default: Date.now

  updated:
    type: Date
    default: Date.now
)

NotificationSchema.statics.formats = 
  HTML: 0
  TEXT: 1

NotificationSchema.statics.message_kinds = 
  GENERAL: 0
  MAINTENANCE: 1
  ALERT: 2

exports.model = NotificationSchema
# module.exports = mongoose.model('Notification', NotificationSchema)