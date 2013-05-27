# Manuall Run via: `mocha tests/user-test.coffee --compilers coffee:coffee-script --reporter Spec`
assert = require "assert"
should = require "should"
config = require "../config"
request = require "request"
mongoose = require "mongoose"
# User = require "../api/models/usersModel"

# db = mongoose.connect config.settings.conn_str
api_url = config.settings.api_host + ':' + config.settings.api_port
project_api_key = '4201d2e8bb26b1c1715bb6e421bb4a131e631603efc8498a4cc3cdc7baf95daa'

describe 'Fan API', () ->
  # Should already be logged in at gerald.leenerts@gmail.com

  # Create a fan on a project
  # Edit a fan
  # Get a fan from a project
  # Delete a fan