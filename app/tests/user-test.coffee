# Manuall Run via: `mocha tests/user-test.coffee --compilers coffee:coffee-script --reporter Spec`
assert = require "assert"
should = require "should"
mongoose = require "mongoose"
api_proxy = require "../api_proxy"


###
  User Tests

  get /auth/login
  post /user
  put /user/:id
  del /user/:id
###

describe 'User API', () ->
  tmp_user = { }
  tmp_user_data = 
    form:
      email: "gerald.leenerts+test@gmail.com"
      first_name: "gerald"
      last_name: "leenerts"
      password: "glee123"

  # It Should create a user
  it "Should create a user", (done) ->
    api_proxy.post '/user', tmp_user_data, "", (err, resp, body) ->
      assert !err
      tmp_user = JSON.parse body
      
      assert.equal tmp_user.success, true
      done()

  # It Should validate a login as user
  it "Should validate a user login", (done) ->
    user_data =
      form:
        email: "gerald.leenerts+test@gmail.com"
        password: "glee123"

    api_proxy.post '/auth/login', user_data, "", (err, resp, body) ->
      assert !err
      json = JSON.parse body

      assert.equal json.success, true
      done()
  
  # It Should find a user by ID
  it "Should find a user by ID", (done) ->
    api_proxy.get '/user/' + tmp_user.user._id, {}, "", (err, resp, body) ->
      assert !err
      json = JSON.parse body

      assert.equal json.success, true
      done()

  # It Should find all users
  it "Should find all users", (done) ->
    api_proxy.get '/user/', {}, "", (err, resp, body) ->
      assert !err
      json = JSON.parse body
      
      assert.equal json.success, true
      done()
  
  # It Should update a user
  it "Should update a user", (done) ->
    user_data = 
      form:
        email: tmp_user_data.form.email
        password: "glee123"
        new_password: "password"
        full_name: "Kit Kat"

    api_proxy.put '/user/' + tmp_user.user._id, user_data, "", (err, resp, body) ->
      assert !err
      json = JSON.parse body

      assert.equal json.success, true
      done()

  # It Should delete the temp user
  it "Should delete a user", (done) ->
    api_proxy.del '/user/' + tmp_user.user._id, {}, "", (err, resp, body) ->
      assert !err
      json = JSON.parse body

      assert.equal json.success, true
      done()