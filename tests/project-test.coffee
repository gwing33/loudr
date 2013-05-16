# Manuall Run via: `mocha tests/user-test.coffee --compilers coffee:coffee-script --reporter Spec`
assert = require "assert"
should = require "should"
config = require "../config"
request = require "request"
mongoose = require "mongoose"
User = require "../api/models/usersModel"

# db = mongoose.connect config.settings.conn_str
api_url = config.settings.api_host + ':' + config.settings.api_port

describe 'User App API', () ->
  # User create a project
  # Validate API Key
  # User Edit a project
  # User disable a project
  # Delete a project (Admin only)
  it "should try and get a project", () ->
    request.get api_url + '/project/1', (err, resp, body) ->
      assert !err

      console.log body
      

#      json = JSON.parse body
#
#      assert.equal json.success, false
#      done()
  
  it "should do a test", () ->
    assert.equal true, true