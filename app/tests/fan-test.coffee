# Manuall Run via: `mocha tests/user-test.coffee --compilers coffee:coffee-script --reporter Spec`
assert = require "assert"
should = require "should"
mongoose = require "mongoose"
api_proxy = require "../api_proxy"

###
  Fan Tests

  get /app/:key/fans
  get /app/:key/fan/:email
  post /app/:key/fan
  put /app/:key/fan/:email
  del /app/:key/fan/:email
###

describe 'Fan API', () ->

  # Should Create Fan
  # Should Get all Fans
  # Should Get Fan By ID
  # Should Update Fan
  # Should Delete Fan


  ###
  # Should already be logged in at gerald.leenerts@gmail.com

  # Create a fan on a project
  it "Create a Fan on an app", (done) ->
    post_data =
      form:
        email: 'gerald.leenerts+fan1@gmail.com'
        groups: ["Gold Membership", "Cicyle in Cirlces"]
        first_name: "Steve"
        last_name: "Steval"
        registered_date: "2013-05-17T17:32:00.171Z"

    request.post api_url + '/fan', post_data, (err, resp, body) ->
      assert !err
      json = JSON.parse body
      fan = json.fan
      
      assert.equal json.success, true
      done()

  # Get a fan from a project
  it "Get a fan by key and email", (done) ->
    request.get api_url + '/fan/gerald.leenerts%2bfan1%40gmail.com', (err, resp, body) ->
      assert !err
      json = JSON.parse body
      fan = json.fan

      assert.equal json.success, true
      done()
  
  # Edit a fan
  it "Edit a fan by key and email", (done) ->
    post_data =
      form:
        groups: ['New Group', 'Gold Membership']
        remove_groups: ['Cicyle in Cirlces']
        registered_date: "2013-04-17T17:32:00.171Z"
        first_name: "Stever"

    request.put api_url + '/fan/gerald.leenerts%2bfan1%40gmail.com', post_data, (err, resp, body) ->
      assert !err
      json = JSON.parse body

      assert.equal json.fan.groups.length, 2
      assert.equal json.success, true
      done()
  
  # Delete a fan
  it "Delete a fan", (done) ->
    request.del api_url + '/fan/gerald.leenerts%2bfan1%40gmail.com', (err, resp, body) ->
      assert !err
      json = JSON.parse body
      
      assert.equal json.success, true
      done()
  ###