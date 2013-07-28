# Manuall Run via: `mocha tests/user-test.coffee --compilers coffee:coffee-script --reporter Spec`
assert = require "assert"
should = require "should"
config = require "../config"
request = require "request"
mongoose = require "mongoose"
User = require "../api/models/usersModel"

api_proxy = require "../api_proxy"


###
  User Tests

  get /auth/login
  post /user
  put /user/:id
  del /user/:id
###

describe 'User API', () ->
  # It should create a user
  # It should validate a login as user
  # It should not validate a user
  # It should update a user
  # It should delete a user





  ###
  tmp_user = { }
  tmp_user_data = 
    form:
      email: "gerald.leenerts+test@gmail.com"
      first_name: "gerald"
      last_name: "leenerts"
      password: "glee123"

  # Fail Login
  it "shouldn't find a user", (done) ->
    post_data = 
      form:
        email: "geral.leenerts+test2@gmail.com"
        password: "glee123"

    request.post api_url + '/auth/login', post_data, (err, resp, body) ->
      assert !err
      json = JSON.parse body

      assert.equal json.success, false
      done()
  
  # Create User
  it "should create a user", (done) ->
    request.post api_url + '/user', tmp_user_data, (err, resp, body) ->
      assert !err
      tmp_user = JSON.parse body
      console.log tmp_user.user._id
      assert.equal tmp_user.success, true
      done()

  # Fail Create
  it "shouldn't create a user", (done) ->
    request.post api_url + '/user', tmp_user_data, (err, resp, body) ->
      assert !err
      json = JSON.parse body

      assert.equal json.success, false
      done()

  it "should find a user", (done) ->
    post_data = 
      form:
        email: tmp_user_data.form.email
        password: "glee123"
      
    request.post api_url + '/auth/login', post_data, (err, resp, body) ->
      assert !err
      json = JSON.parse body

      assert.equal json.success, true
      done()

  it "should change the password", (done) ->
    put_data = 
      form:
        email: tmp_user_data.form.email
        password: "glee123"
        new_password: "password"
        full_name: "Kit Kat"

    request.put api_url + '/user/' + tmp_user.user._id, put_data, (err, resp, body) ->
      assert !err
      json = JSON.parse body

      assert.equal json.success, true
      assert.equal json.user.name.full, "Kit Kat"
      
      done()

  it "should be invalid password now", (done) ->
    post_data = 
      form:
        email: tmp_user_data.form.email
        password: "glee123"
      
    request.post api_url + '/auth/login', post_data, (err, resp, body) ->
      assert !err
      json = JSON.parse body
      
      assert.equal json.success, false
      done()

  it "should be valid new password now", (done) ->
    post_data = 
      form:
        email: tmp_user_data.form.email
        password: "password"
      
    request.post api_url + '/auth/login', post_data, (err, resp, body) ->
      assert !err
      json = JSON.parse body

      assert.equal json.success, true
      done()

  it "should change the name", (done) ->
    put_data = 
      form:
        full_name: "Gerald Leenerts III"

    request.put api_url + '/user/' + tmp_user.user._id, put_data, (err, resp, body) ->
      assert !err
      json = JSON.parse body

      assert.equal json.user.name.full, "Gerald Leenerts III"
      assert.equal json.success, true
      done()

  # http://localhost:3001/user/gerald.leenerts&2Btest@gmail.com
  it "should get user by email", (done) ->
    request.get api_url + '/user/gerald.leenerts%2Btest@gmail.com', (err, resp, body) ->
      assert !err
      json = JSON.parse body

      assert.equal json.user.name.full, "Gerald Leenerts III"
      assert.equal json.success, true
      done()

  it "should get user by id", (done) ->
    User.getById tmp_user.user._id, (err, user) ->
      assert !err
      assert user 
      done()

  # delete an existing user
  it "should delete a user", (done) ->
    request.del api_url + '/user/' + tmp_user.user._id, (err, resp, body) ->
      assert !err
      json = JSON.parse body
      assert.equal json.success, true
      done()

  it "shouldn't find a user after deleting", (done) ->
    User.getById tmp_user.user._id, (err, user) ->
      assert !err
      assert !user
      done()
  ###