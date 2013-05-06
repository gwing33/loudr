# Manuall Run via: `mocha tests/user-test.coffee --compilers coffee:coffee-script --reporter Spec`
assert = require "assert"
should = require "should"
config = require "../config"
request = require "request"

api_url = config.settings.api_host + ':' + config.settings.api_port

describe 'Loudr API', () ->
  describe 'Invalid User', () ->
    it "shouldn't find a user", (done) ->
      post_data = 
        form:
          email: "geral.leenerts@gmail.com"
          password: "glee123"
        
      request.post api_url + '/auth/login', post_data, (err, resp, body) ->
        assert(!err)
        json = JSON.parse body

        assert.equal json.success, false
        done()

  describe 'Dupldate Key on User', () ->
    it "should create a user", (done) ->
      new_user_data = 
        form:
          email: "gerald.leenerts@gmail.com"
          first_name: "gerald"
          last_name: "leenerts"
          password: "glee123"
      
      request.post api_url + '/user', new_user_data, (err, resp, body) ->
        assert(!err)
        json = JSON.parse body

        assert.equal json.success, false
        done()