# Manuall Run via: `mocha tests/user-test.coffee --compilers coffee:coffee-script --reporter Spec`
assert = require "assert"
should = require "should"
config = require "../config"
request = require "request"
mongoose = require "mongoose"
NotificationSchema = require "../api/models/notificationsSchema"
Notification = mongoose.model 'Notification', NotificationSchema.model

# db = mongoose.connect config.settings.conn_str
project_api_key = '4201d2e8bb26b1c1715bb6e421bb4a131e631603efc8498a4cc3cdc7baf95daa'
fan_email = 'gerald.leenerts%2bpeon_seed%40gamil.com'
api_url = config.settings.api_host + ':' + config.settings.api_port + '/app/' + project_api_key + '/fan/' + fan_email
note = {}

describe 'Fan Notificaiton API', () ->
  # Should already be logged in at gerald.leenerts@gmail.com

  # Create a fan on a project
  it "Create a new Notification for a Fan", (done) ->
    post_data =
      form:
        text: 'Hello World'
        url: 'http://www.google.com'
        format: Notification.formats.TEXT
        

    request.post api_url + '/note', post_data, (err, resp, body) ->
      assert !err
      json = JSON.parse body
      note = json.notification
      
      assert.equal json.success, true
      done()

  # Get a fan from a project
  it "Get a fan notification", (done) ->
    request.get api_url + '/note/' + note._id, (err, resp, body) ->
      assert !err
      json = JSON.parse body

      assert.equal json.success, true
      done()
  
  # Edit a fan
  it "Edit a fan notification", (done) ->
    post_data =
      form:
        text: 'Hell World'
        url: 'http://www.twitter.com'

    request.put api_url + '/note/' + note._id, post_data, (err, resp, body) ->
      assert !err
      json = JSON.parse body

      assert.equal json.success, true
      done()
  
  # Delete a fan
  it "Delete a fan notificaiton", (done) ->
    request.del api_url + '/note/' + note._id, (err, resp, body) ->
      assert !err
      json = JSON.parse body
      
      assert.equal json.success, true
      done()