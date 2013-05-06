# mongoose = require('mongoose')
# User = require('../api/models/users')
# connStr = 'mongodb://localhost:27017/mongoose-bcrypt-test'
# 
# mongoose.connect connStr, (err) ->
#   throw err if err
#   console.log('Successfully connected to MongoDB')
 
###
# create a user a new user
testUser = new User
  email: 'gwing33'
  password: 'Password123'
 
# save user to database
testUser.save (err) ->
  throw err if err

  console.log('hello')

  # fetch user and test password verification
  User.findOne
    email: 'gwing33'
    , (err, user) ->
      throw err if err
      # test a matching password
      user.comparePassword 'Password123', (err, matched) ->
        throw err if err
        console.log('Password123:', matched)

      # test a failing password
      user.comparePassword '123Password', (err, matched) ->
        throw err if err
        console.log('123Password:', matched)
###


# fetch user and test password verification
# User.findOne
#   email: 'gwing33'
#   , (err, user) ->
#     throw err if err
#     # test a matching password
#     user.comparePassword 'Password123', (err, matched) ->
#       throw err if err
#       console.log('Password123:', matched)
# 
#     # test a failing password
#     user.comparePassword '123Password', (err, matched) ->
#       throw err if err
#       console.log('123Password:', matched)