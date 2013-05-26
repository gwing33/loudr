mongoose = require("mongoose")
bcrypt = require("bcrypt")
# Project = require("./projectsModel")

Schema = mongoose.Schema

SALT_WORK_FACTOR = 10

UserSchema = new Schema(
  email:
    type: String
    required: true
    index:
      unique: true

  name:
    first:
      type: String
    last:
      type: String

  password:
    type: String
    required: true

  loginAttempts:
    type: Number
    required: true
    default: 0
  
  locked:
    type: Boolean
    default: false

  is_super:
    type: Boolean
    default: false

  permissions: [
    valid_untill: Date
    subscription: String
  ]

  stripe_token: String
)

UserSchema.pre 'save', (next) ->
  user = this
  return next() unless user.isModified("password")

  # generate a salt
  bcrypt.genSalt SALT_WORK_FACTOR, (err, salt) ->
    return next err if err
    bcrypt.hash user.password, salt, (err, hash) ->
      return next err if err
      user.password = hash
      next()

UserSchema.methods.comparePassword = (candidatePassword, cb) ->
  bcrypt.compare candidatePassword, @password, (err, isMatch) ->
    return cb err if err
    cb null, isMatch

UserSchema.virtual('name.full').get(() ->
    return @.name.first + ' ' + @.name.last
  ).set (name) ->
    split = name.split(' ')
    @.name.first = split[0]
    
    if split.length > 2
      split.splice 0, 1
      @.name.last = split.join(' ')
    else
      @.name.last = split[1]

UserSchema.methods.toJson = () ->
  user_obj =
    _id: @._id
    email: @.email
    name:
      first: @name.first
      last: @name.last
      full: @.name.full
    loginAttempts: @.loginAttempts
    locked: @.locked

  return user_obj

UserSchema.methods.incLoginAttempts = (cb) ->
  updates = $inc:
    loginAttempts: 1

  # lock the account if we've reached max attempts and it's not locked already
  updates.$set = locked: (@loginAttempts + 1 >= @MAX_LOGIN_ATTEMPTS and not @locked)
  @update updates, cb


reasons = UserSchema.statics.failedLogin = 
  NOT_FOUND: 0
  PASSWORD_INCORRECT: 1
  MAX_ATTEMPTS: 5

UserSchema.statics.getById = (id, cb) ->
  @findOne
    _id: id
  , (err, user) ->
    return cb err if err
    return cb null, null, reasons.NOT_FOUND unless user

    cb null, user

UserSchema.statics.getByEmail = (email, cb) ->
  @findOne
    email: email
  , (err, user) ->
    return cb err if err
    return cb null, null, reasons.NOT_FOUND unless user

    cb null, user

UserSchema.statics.getAllByEmails = (emails, cb) ->
  @find
    email:
      $in: emails
  , (err, users) ->
    return cb err if err
    return cb reasons.NOT_FOUND, null unless users

    cb null, users

UserSchema.statics.removeById = (id, cb) ->
  @findOne
    _id: id
  , (err, user) ->
    return cb err if err
    return cb reasons.NOT_FOUND, null unless user
    user.remove()
    
    cb null, true

UserSchema.statics.getAuthenticated = (email, password, cb) ->
  @findOne
    email: email
  , (err, user) ->
    return cb err if err
    return cb null, null, reasons.NOT_FOUND unless user
    if user.locked
      return user.incLoginAttempts((err) ->
        return cb(err) if err
        cb null, null, reasons.MAX_ATTEMPTS
      )
    user.comparePassword password, (err, isMatch) ->
      return cb err if err
      if isMatch
        return cb(null, user) if not user.loginAttempts and not user.lockUntil
        updates =
          $set:
            loginAttempts: 0

          $unset:
            lockUntil: 1

        return user.update(updates, (err) ->
          return cb(err) if err
          cb null, user
        )
      user.incLoginAttempts (err) ->
        return cb(err) if err
        cb null, null, reasons.PASSWORD_INCORRECT

module.exports = mongoose.model('User', UserSchema)