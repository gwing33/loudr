# Manuall Run via: `mocha tests/user-test.coffee --compilers coffee:coffee-script --reporter Spec`
assert = require "assert"
should = require "should"
config = require "../config"
request = require "request"
mongoose = require "mongoose"
User = require "../api/models/usersModel"

# db = mongoose.connect config.settings.conn_str
api_url = config.settings.api_host + ':' + config.settings.api_port
user = {}

describe 'Project API', () ->
  # Login
  it "Login as test user", (done) ->
    post_data = 
      form:
        email: "gerald.leenerts@gmail.com"
        password: "glee123"

    request.post api_url + '/auth/login', post_data, (err, resp, body) ->
      assert !err
      json = JSON.parse body
      console.log json.user._id
      assert.equal json.success, true
      done()

  # User create a project
  it "User create an App", (done) ->
    post_data =
      form:
        name: 'Test Project'
    # request.post
    request.post api_url + '/project', post_data, (err, resp, body) ->
      assert !err
      project = JSON.parse body
      
      assert.equal project.success, true
      done()

  
  # Validate API Key
  # User Edit a project
  # User disable a project
  # Delete a project (Admin only)
#  it "should try and get a project", () ->
#    request.get api_url + '/project/1', (err, resp, body) ->
#      assert !err
#
#      console.log body
      

#      json = JSON.parse body
#
#      assert.equal json.success, false
#      done()
  
  it "should do a test", () ->
    assert.equal true, true