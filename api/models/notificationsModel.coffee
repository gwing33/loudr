mongoose = require("mongoose")

Schema = mongoose.Schema

NotificationSchema = new Schema(
  message:
    html: 
      type: String
    text:
      type: String
    url:
      type: String

  format:
    type: Number
    default: 0

  message_type:
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
)

NotificationSchema.statics.formats = 
  HTML: 0
  TEXT: 1

NotificationSchema.statics.message_types = 
  GENERAL: 0
  MAINTENANCE: 1
  ALERT: 2


module.exports = mongoose.model('Notifications', NotificationSchema)