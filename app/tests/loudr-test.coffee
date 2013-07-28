assert = require "assert"
should = require "should"

describe 'Loudr API', () ->

  # Should create a user
  # Should validate a user login
  # Should find a user by ID
  # Should find all users
  # Should update a user
  # Should delete a user 
  require './user-test'

  # Should login as a user
  # Should Create a Project 
  # Should Find all Projects 
  # Should Find Project by ID 
  # Should Update a project 
  # Should Add User to Project 
  # Should Delete the Project 
  require './project-test'

  # get /app/:key/fans
  # get /app/:key/fan/:email
  # post /app/:key/fan
  # put /app/:key/fan/:email
  # del /app/:key/fan/:email
  require './fan-test'

  # get /app/:key/fan/:email/notes
  # get /app/:key/fan/:email/note/:id
  # post /app/:key/fan/:email/note
  # put /app/:key/fan/:email/note/:id
  # del /app/:key/fan/:email/note/:id
  require './notification-test'