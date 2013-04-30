mongoose = require("mongoose")
Schema = mongoose.Schema
bcrypt = require("bcrypt")
SALT_WORK_FACTOR = 10

UserSchema = new Schema(
  email:
    type: String
    required: true
    index:
      unique: true

  first_name:
    type: String

  last_name:
    type: String

  password:
    type: String
    required: true
)

UserSchema.pre 'save', (next) ->
  user = this
  return next() unless user.isModified("password")

  # generate a salt
  bcrypt.genSalt SALT_WORK_FACTOR, (err, salt) ->
    return next(err) if err
    bcrypt.hash user.password, salt, (err, hash) ->
      return next(err) if err
      user.password = hash
      next()

UserSchema.methods.comparePassword = (candidatePassword, cb) ->
  bcrypt.compare candidatePassword, @password, (err, isMatch) ->
    return cb(err)  if err
    cb null, isMatch

module.exports = mongoose.model('User', UserSchema)