assert = require "assert"
should = require "should"
config = require "../config"
request = require "request"
mongoose = require "mongoose"
User = require "../api/models/usersModel"

db = mongoose.connect config.settings.conn_str
api_url = config.settings.api_host + ':' + config.settings.api_port

describe 'Loudr API', () ->
  require './user-test'

  require './project-test'

  require './fan-test'