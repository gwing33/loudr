assert = require "assert"
should = require "should"

describe 'Loudr API', () ->

  # should create a user
  # should validate a user login
  # should find a user by ID
  # should find all users
  # should update a user
  # should delete a user 
  require './user-test'

  # get /project'
  # get /project/:id'
  # post /project'
  # put /project/:id'
  # del /project/:id'
  # del /project/confirm/:id'
  # del /project/disable/:id'
  # get /project/enable/:id'
  #require './project-test'

  # get /app/:key/fans
  # get /app/:key/fan/:email
  # post /app/:key/fan
  # put /app/:key/fan/:email
  # del /app/:key/fan/:email
  #require './fan-test'

  # get /app/:key/fan/:email/notes
  # get /app/:key/fan/:email/note/:id
  # post /app/:key/fan/:email/note
  # put /app/:key/fan/:email/note/:id
  # del /app/:key/fan/:email/note/:id
  #require './notification-test'