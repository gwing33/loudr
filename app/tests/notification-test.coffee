# Manuall Run via: `mocha tests/user-test.coffee --compilers coffee:coffee-script --reporter Spec`
assert = require "assert"
should = require "should"
mongoose = require "mongoose"
api_proxy = require "../api_proxy"


###
 Notification Tests

 get /app/:key/fan/:email/notes
 get /app/:key/fan/:email/note/:id
 post /app/:key/fan/:email/note
 put /app/:key/fan/:email/note/:id
 del /app/:key/fan/:email/note/:id
###

describe 'Fan Notificaiton API', () ->
  # Should Create Notification
  # Should Get all Notifications
  # Should Get Notification By ID
  # Should Update Notification
  # Should Delete Notification

  ###
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
  ###