# Manuall Run via: `mocha tests/user-test.coffee --compilers coffee:coffee-script --reporter Spec`
assert = require "assert"
should = require "should"
config = require "../config"
request = require "request"
mongoose = require "mongoose"
# User = require "../api/models/usersModel"

# db = mongoose.connect config.settings.conn_str
api_url = config.settings.api_host + ':' + config.settings.api_port
project = {}

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
      json = JSON.parse body
      project = json.project

      assert.equal json.success, true
      done()

  # Edit Project
  it "Edit Project", (done) ->
    post_data =
      form:
        name: 'My awesome Application'

    request.put api_url + '/project/' + project._id, post_data, (err, resp, body) ->
      assert !err
      json = JSON.parse body

      assert.equal json.project.name, 'My awesome Application'
      assert.equal json.success, true
      done()

  # Validate API Key
  # User disable a project
  # Delete a project (Admin only)