mongoose = require("mongoose")
Notifications = require("./notificationsModel")

Schema = mongoose.Schema

# Named them fans to avoid something like having "users" and "application users" confusion
FanSchema = new Schema(
  name:
    first:
      type: String
    last:
      type: String
  
  social:
    facebook:
      type: String
    twitter:
      type: String
    klout:
      type: String


  notifications: [Notifications]
 
  info:
    logins: [Date]

    # This is the date they signed up for the applicaiton
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


module.exports = mongoose.model('Fan', FanSchema)