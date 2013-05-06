# Manuall Run via: `mocha tests/user-test.coffee --compilers coffee:coffee-script --reporter Spec`
assert = require "assert"
should = require "should"
config = require "../config"
request = require "request"
mongoose = require "mongoose"
User = require "../api/models/users"

db = mongoose.connect config.settings.conn_str
api_url = config.settings.api_host + ':' + config.settings.api_port

describe 'Loudr API', () ->
  describe 'User API', () ->
    tmp_user = { }
    tmp_user_data = 
      form:
        email: "gerald.leenerts+test@gmail.com"
        first_name: "gerald"
        last_name: "leenerts"
        password: "glee123"

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
    
    it "should create a user", (done) ->
      request.post api_url + '/user', tmp_user_data, (err, resp, body) ->
        assert !err
        tmp_user = JSON.parse body
        assert.equal tmp_user.success, true
        done()

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

    it "should get user by id", (done) ->
      User.getById tmp_user._id, (err, user) ->
        assert !err
        assert user 
        done()

    # delete an existing user
    it "should delete a user", (done) ->
      request.del api_url + '/user/' + tmp_user._id, (err, resp, body) ->
        assert !err
        json = JSON.parse body
        assert.equal json.success, true
        done()

    it "shouldn't find a user after deleting", (done) ->
      User.getById tmp_user._id, (err, user) ->
        assert !err
        assert !user
        done()