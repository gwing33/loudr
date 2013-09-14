# Manuall Run via: `mocha tests/user-test.coffee --compilers coffee:coffee-script --reporter Spec`
assert = require "assert"
should = require "should"
mongoose = require "mongoose"
api_proxy = require "../api_proxy"

project = {}
user = {}

###
  Project Tests

  get /user/:user_id/project
  get /user/:user_id/project/:id
  post /user/:user_id/project
  put /user/:user_id/project/:id
  del /user/:user_id/project/:id
###

describe 'Project API', () ->
  

  # Prep
  it "Should Prep", (done) ->
    user_data =
      form:
        email: "gerald.leenerts@gmail.com"
        password: "glee123"

    api_proxy.post '/auth/login', user_data, "", (err, resp, body) ->
      assert !err
      json = JSON.parse body

      user = json.user
      assert.equal json.success, true
      done()

  # Should Create Project
  it "Should Create a Project", (done) ->
    post_data =
      form:
        name: 'Test Project'
        api:
          is_secure: true
    # request.post
    api_proxy.post '/user/' + user._id + '/project', post_data, "", (err, resp, body) ->
      assert !err
      json = JSON.parse body
      
      project = json.project

      assert.equal json.success, true
      done()


  # Should Find all Projects
  it "Should Find all Projects", (done) ->
    api_proxy.get '/user/' + user._id + '/project', {}, "", (err, resp, body) ->
      assert !err
      json = JSON.parse body
      
      assert.equal json.success, true
      done()

  # Should Find Project by ID
  it "Should Find Project by ID", (done) ->
    api_proxy.get '/user/' + user._id + '/project/' + project._id, {}, project.api.key, (err, resp, body) ->
      assert !err
      json = JSON.parse body
      
      assert.equal json.success, true
      done()

  # Should Find Project by ID *AUTH*
  it "Should Find Project by ID *AUTH*", (done) ->
    api_proxy.unsigned_get '/user/' + user._id + '/project/' + project._id, {}, project.api.key, (err, resp, body) ->
      assert !err
      json = JSON.parse body
      
      assert.equal json.success, true
      done()

  # Should Update project
  it "Should Update a project", (done) ->
    post_data =
      form:
        name: 'My AWESOME Application'

    api_proxy.put '/user/' + user._id + '/project/' + project._id, post_data, project.api.key, (err, resp, body) ->
      assert !err
      json = JSON.parse body

      assert.equal json.success, true
      assert.equal json.project.name, 'My AWESOME Application'
      done()

  # Should Add User to Project
  it "Should Add User to Project", (done) ->
    post_data =
      form:
        emails: ['gerald.leenerts+peon@gmail.com']

    api_proxy.put '/user/' + user._id + '/project/' + project._id, post_data, project.api.key, (err, resp, body) ->
      assert !err
      json = JSON.parse body
      
      assert.equal json.project.users.length, 2
      assert.equal json.success, true
      done()

  # Should Delete Project
  it "Should Delete the Project", (done) ->
    api_proxy.del '/user/' + user._id + '/project/' + project._id, {}, project.api.key, (err, resp, body) ->
      assert !err
      json = JSON.parse body

      assert.equal json.success, true
      done()