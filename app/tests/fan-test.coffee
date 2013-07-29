# Manuall Run via: `mocha tests/user-test.coffee --compilers coffee:coffee-script --reporter Spec`
assert = require "assert"
should = require "should"
mongoose = require "mongoose"
api_proxy = require "../api_proxy"

###
  Fan Tests

  get /app/fan/:id
  post /app/fan
  put /app/fan/:id
  del /app/fan/:id

  get /app/:key/fan
  get /app/:key/fan/:email
  put /app/:key/fan/:email
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

  # Should 401
  it "Should 401", (done) ->
    api_proxy.get '/app/fan/' + fan._id, {}, 'blah', (err, resp, body) ->
      assert !err
      assert.equal resp.statusCode, 401
      
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

    api_proxy.post '/app/fan/', post_data, project.api.key, (err, resp, body) ->
      assert !err

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

  # Should Get Fan By ID
  it "Should Get Fan By ID", (done) ->
    api_proxy.get '/app/fan/' + fan._id, {}, project.api.key, (err, resp, body) ->
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

  # Should Update Fan
  it "Should Update Fan", (done) ->
    post_data =
      form:
        groups: ['New Group', 'Gold Membership']
        remove_groups: ['Cicyle in Cirlces']
        registered_date: "2013-04-17T17:32:00.171Z"
        first_name: "Stever"

    api_proxy.put '/app/fan/' + fan._id, post_data, project.api.key, (err, resp, body) ->
      assert !err
      json = JSON.parse body

      assert.equal json.fan.groups.length, 2
      assert.equal json.success, true
      done()

  # Should Update Fan by Key/Email
  it "Should Update Fan by Key/Email", (done) ->
    post_data =
      form:
        remove_groups: ['New Group']

    api_proxy.put '/app/' + project.api.key + '/fan/' + fan.email, post_data, project.api.key, (err, resp, body) ->
      assert !err
      json = JSON.parse body

      assert.equal json.fan.groups.length, 1
      assert.equal json.success, true
      done()

  # Should Delete Fan
  it "Should Delete Fan", (done) ->
    api_proxy.del '/app/fan/' + fan._id, {}, project.api.key, (err, resp, body) ->
      assert !err

      json = JSON.parse body
      assert.equal json.success, true

      done()