assert = require "assert"
should = require "should"
config = require "../config"
request = require "request"
mongoose = require "mongoose"
User = require "../api/models/usersModel"

db = mongoose.connect config.settings.conn_str
api_url = config.settings.api_host + ':' + config.settings.api_port

describe 'Loudr API', () ->

  # get /user/:email
  # post /user
  # put /user/:id
  # del /user/:id
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