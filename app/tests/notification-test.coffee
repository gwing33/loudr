
assert = require "assert"
should = require "should"
mongoose = require "mongoose"
NotificationSchema = require "../../api/models/notificationsSchema"
Notification = mongoose.model 'Notification', NotificationSchema.model
api_proxy = require "../api_proxy"


###
  Notification Tests

  get /app/fan/:fan_id/note
  get /app/fan/:fan_id/note/:id
  post /app/fan/:fan_id/note
  put /app/fan/:fan_id/note/:id
  del /app/fan/:fan_id/note/:id

  get /app/:key/fan/:email/note
  get /app/:key/fan/:email/note/:id
  post /app/:key/fan/:email/note
  put /app/:key/fan/:email/note/:id
  del /app/:key/fan/:email/note/:id
###

user = {}
project = {}
fan = {}
note = {}
note2 = {}

describe 'Fan Notificaiton API', () ->
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
        post_data =
          form:
            api_key: project.api.key
            email: 'gerald.leenerts+fan2@gmail.com'
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

  # Should Create Notification
  it "Should Create Notification", (done) ->
    post_data =
      form:
        text: 'Hello World'
        url: 'http://www.google.com'
        format: Notification.formats.TEXT

    api_proxy.post '/app/fan/' + fan._id + '/note', post_data, project.api.key, (err, resp, body) ->
      assert !err
      json = JSON.parse body
      note = json.notification
      
      assert.equal json.success, true
      done()

  # Should Create Notification By Key/Email
  it "Should Create Notification By Key/Email", (done) ->
    post_data =
      form:
        text: 'Hello World 2'
        url: 'http://www.google.com'
        format: Notification.formats.TEXT

    api_proxy.post '/app/' + project.api.key + '/fan/' + fan.email + '/note', post_data, project.api.key, (err, resp, body) ->
      assert !err
      json = JSON.parse body
      note2 = json.notification
      
      assert.equal json.success, true
      done()

  # Should Get all Notifications
  it "Should Get all Notifications", (done) ->
    api_proxy.get '/app/fan/' + fan._id + '/note/', {}, project.api.key, (err, resp, body) ->
      assert !err
      json = JSON.parse body

      assert.equal json.success, true
      done()

  # Should Get all Notifications By Key/Email
  it "Should Get all Notifications By Key/Email", (done) ->
    api_proxy.get '/app/' + project.api.key + '/fan/' + fan.email + '/note/', {}, project.api.key, (err, resp, body) ->
      assert !err
      json = JSON.parse body

      assert.equal json.success, true
      done()

  # Should Get a Notification
  it "Should Get a Notification", (done) ->
    api_proxy.get '/app/fan/' + fan._id + '/note/' + note._id, {}, project.api.key, (err, resp, body) ->
      assert !err
      json = JSON.parse body

      assert.equal json.success, true
      done()

  # Should Get a Notification By Key/Email
  it "Should Get a Notification By Key/Email", (done) ->
    api_proxy.get '/app/' + project.api.key + '/fan/' + fan.email + '/note/' + note._id, {}, project.api.key, (err, resp, body) ->
      assert !err
      json = JSON.parse body

      assert.equal json.success, true
      done()

  # Should Update Notification
  it "Should Update Notification", (done) ->
    post_data =
      form:
        text: 'Hell World'
        url: 'http://www.twitter.com'

    api_proxy.put '/app/fan/' + fan._id + '/note/' + note._id, post_data, project.api.key, (err, resp, body) ->
      assert !err
      json = JSON.parse body

      assert.equal json.success, true
      assert.equal json.notification.text, 'Hell World'
      done()

  # Should Update Notification By Key/Email
  it "Should Update Notification By Key/Email", (done) ->
    post_data =
      form:
        text: 'Hell World 3'

    api_proxy.put '/app/' + project.api.key + '/fan/' + fan.email + '/note/' + note._id, post_data, project.api.key, (err, resp, body) ->
      assert !err
      json = JSON.parse body

      assert.equal json.success, true
      assert.equal json.notification.text, 'Hell World 3'
      done()

  # Should Delete a Notification
  it "Should Delete a Notification", (done) ->
    api_proxy.del '/app/fan/' + fan._id + '/note/' + note._id, {}, project.api.key, (err, resp, body) ->
      assert !err
      json = JSON.parse body
      
      assert.equal json.success, true
      done()
  
  # Should Delete a Notification By Key/Email
  it "Should Delete a Notification By Key/Email", (done) ->
    api_proxy.del '/app/' + project.api.key + '/fan/' + fan.email + '/note/' + note._id, {}, project.api.key, (err, resp, body) ->
      assert !err
      json = JSON.parse body
      
      assert.equal json.success, true
      done()

  # Cleanup
  it "Should Cleanup", (done) ->
    api_proxy.del '/app/fan/' + fan._id, {}, project.api.key, (err, resp, body) ->
      assert !err

      json = JSON.parse body
      assert.equal json.success, true

      done()