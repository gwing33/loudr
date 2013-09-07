# Manuall Run via: `mocha tests/user-test.coffee --compilers coffee:coffee-script --reporter Spec`
assert = require "assert"
should = require "should"
mongoose = require "mongoose"
api_proxy = require "../api_proxy"

###
  Fan Tests

  get /app/:key/fan
  post /app/:key/fan
  get /app/:key/fan/:email
  put /app/:key/fan/:email
  del /app/:key/fan/:id
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
        api_key: project.api.key
        email: 'gerald.leenerts+fan1@gmail.com'
        groups: ["Gold Membership", "Cicyle in Cirlces"]
        first_name: "Steve"
        last_name: "Steval"
        registered_date: "2013-05-17T17:32:00.171Z"

    api_proxy.post '/app/' + project.api.key + '/fan/', post_data, project.api.key, (err, resp, body) ->
      assert !err
      assert.notEqual body, 'Unauthorized'

      json = JSON.parse body
      assert.equal json.success, true

      fan = json.fan
      done()

  # Should Get all Fans by Key
  it "Should Get all Fans", (done) ->
    api_proxy.get '/app/' + project.api.key + '/fan/', {}, project.api.key, (err, resp, body) ->
      assert !err

      json = JSON.parse body
      assert.equal json.success, true

      done()

  # Should Get Fan By Key/Email
  it "Should Get Fan By Key/Email", (done) ->
    api_proxy.get '/app/' + project.api.key + '/fan/' + fan.email, {}, project.api.key, (err, resp, body) ->
      assert !err

      json = JSON.parse body
      assert.equal json.success, true

      done()

  # Should Update Fan by Key/Email
  it "Should Update Fan by Key/Email", (done) ->
    post_data =
      form:
        remove_groups: ['Gold Membership']

    api_proxy.put '/app/' + project.api.key + '/fan/' + fan.email, post_data, project.api.key, (err, resp, body) ->
      assert !err
      json = JSON.parse body

      assert.equal json.fan.groups.length, 1
      assert.equal json.success, true
      done()

  # Should Delete Fan
  it "Should Delete Fan", (done) ->
    api_proxy.del '/app/' + project.api.key + '/fan/' + fan._id, {}, project.api.key, (err, resp, body) ->
      assert !err

      json = JSON.parse body
      assert.equal json.success, true

      done()