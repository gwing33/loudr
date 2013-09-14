# Manuall Run via: `mocha tests/fan-test.coffee --compilers coffee:coffee-script --reporter Spec`
assert = require "assert"
should = require "should"
mongoose = require "mongoose"
api_proxy = require "../api_proxy"

###
  Fan Tests

  get /project/:project_id/fan
  post /project/:project_id/fan
  get /project/:project_id/fan/:fan_handle
  put /project/:project_id/fan/:fan_handle
  del /project/:project_id/fan/:fan_handle
###

user = {}
project = {}
fan = {}

describe 'Fan API', () ->
  # Prep
  it "Should prep", (done) ->
    user_data =
      form:
        email: "gerald.leenerts@gmail.com"
        password: "glee123"

    api_proxy.post '/auth/login', user_data, "", (err, resp, body) ->
      assert !err

      json = JSON.parse body
      assert.equal json.success, true
      
      user = json.user

      api_proxy.get '/user/' + user._id + '/project/', {}, "", (err, resp, body) ->
        assert !err

        json = JSON.parse body
        assert.equal json.success, true
        
        project = json.projects[0]
        done()

  # Should Create Fan
  it "Should Create Fan", (done) ->
    post_data =
      form:
        project_id: project._id
        email: 'gerald.leenerts+fan1@gmail.com'
        groups: ["Gold Membership", "Cicyle in Cirlces"]
        first_name: "Steve"
        last_name: "Steval"
        registered_date: "2013-05-17T17:32:00.171Z"

    api_proxy.post '/project/' + project._id + '/fan/', post_data, project.api.key, (err, resp, body) ->
      assert !err
      assert.notEqual body, 'Unauthorized'

      json = JSON.parse body
      assert.equal json.success, true

      fan = json.fan
      done()

  # Should Get all Fans by Key
  it "Should Get all Fans", (done) ->
    api_proxy.get '/project/' + project._id + '/fan/', {}, project.api.key, (err, resp, body) ->
      assert !err

      json = JSON.parse body
      assert.equal json.success, true

      done()

  # Should Get Fan By Email
  it "Should Get Fan By Email", (done) ->
    api_proxy.get '/project/' + project._id + '/fan/' + fan.email, {}, project.api.key, (err, resp, body) ->
      assert !err

      json = JSON.parse body
      assert.equal json.success, true

      done()

  # Should Update Fan by Email
  it "Should Update Fan by Email", (done) ->
    post_data =
      form:
        remove_groups: ['Gold Membership']

    api_proxy.put '/project/' + project._id + '/fan/' + fan.email, post_data, project.api.key, (err, resp, body) ->
      assert !err
      json = JSON.parse body

      assert.equal json.fan.groups.length, 1
      assert.equal json.success, true
      done()

  # Should Delete Fan
  it "Should Delete Fan", (done) ->
    api_proxy.del '/project/' + project._id + '/fan/' + fan.email, {}, project.api.key, (err, resp, body) ->
      assert !err

      json = JSON.parse body
      assert.equal json.success, true

      done()