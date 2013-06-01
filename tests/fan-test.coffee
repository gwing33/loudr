# Manuall Run via: `mocha tests/user-test.coffee --compilers coffee:coffee-script --reporter Spec`
assert = require "assert"
should = require "should"
config = require "../config"
request = require "request"
mongoose = require "mongoose"
# User = require "../api/models/usersModel"

# db = mongoose.connect config.settings.conn_str
project_api_key = '4201d2e8bb26b1c1715bb6e421bb4a131e631603efc8498a4cc3cdc7baf95daa'
api_url = config.settings.api_host + ':' + config.settings.api_port + '/app/' + project_api_key

describe 'Fan API', () ->
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