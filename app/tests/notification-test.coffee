assert = require "assert"
should = require "should"
mongoose = require "mongoose"
NotificationSchema = require "../../api/models/notificationsSchema"
Notification = mongoose.model 'Notification', NotificationSchema.model
api_proxy = require "../api_proxy"


###
  Notification Tests

  GET /project/:project_id/fan/:fan_handle/note
  GET /project/:project_id/fan/:fan_handle/note/:id
  POST /project/:project_id/fan/:fan_handle/note
  PUT /project/:project_id/fan/:fan_handle/note/:id
  DEL /project/:project_id/fan/:fan_handle/note/:id
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
      
      api_proxy.get '/user/' + user._id + '/project', {}, "", (err, resp, body) ->
        assert !err

        json = JSON.parse body
        assert.equal json.success, true
        
        project = json.projects[0]
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

  # Should Create Notification
  it "Should Create Notification", (done) ->
    post_data =
      form:
        text: 'Hello World'
        url: 'http://www.google.com'
        format: Notification.formats.TEXT

    api_proxy.post '/project/' + project._id + '/fan/' + fan._id + '/note', post_data, project.api.key, (err, resp, body) ->
      assert !err
      json = JSON.parse body

      note = json.notification
      
      assert.equal json.success, true
      done()

  # Should Not Create Notification
  it "Should Not Create Notification", (done) ->
    post_data =
      form:
        format: Notification.formats.TEXT

    api_proxy.post '/project/' + project._id + '/fan/' + fan._id + '/note', post_data, project.api.key, (err, resp, body) ->
      assert !err
      json = JSON.parse body
      
      assert.equal json.success, false
      done()

  # Should Get all Notifications
  it "Should Get all Notifications", (done) ->
    api_proxy.get '/project/' + project._id + '/fan/' + fan._id + '/note/', {}, project.api.key, (err, resp, body) ->
      assert !err
      json = JSON.parse body
      
      assert.equal json.success, true
      done()

  # Should Get a Notification
  it "Should Get a Notification", (done) ->
    api_proxy.get '/project/' + project._id + '/fan/' + fan._id + '/note/' + note._id, {}, project.api.key, (err, resp, body) ->
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

    api_proxy.put '/project/' + project._id + '/fan/' + fan._id + '/note/' + note._id, post_data, project.api.key, (err, resp, body) ->
      assert !err
      json = JSON.parse body

      assert.equal json.success, true
      assert.equal json.notification.text, 'Hell World'
      done()

  # Should Delete a Notification
  it "Should Delete a Notification", (done) ->
    api_proxy.del '/project/' + project._id + '/fan/' + fan._id + '/note/' + note._id, {}, project.api.key, (err, resp, body) ->
      assert !err
      json = JSON.parse body
      
      assert.equal json.success, true
      done()

  # Cleanup
  it "Should Cleanup", (done) ->
    api_proxy.del '/project/' + project._id + '/fan/' + fan.email, {}, project.api.key, (err, resp, body) ->
      assert !err

      json = JSON.parse body
      console.log 
      assert.equal json.success, true

      done()