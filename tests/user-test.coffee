# Manuall Run via: `mocha tests/user-test.coffee --compilers coffee:coffee-script --reporter Spec`
assert = require "assert"
should = require "should"
config = require "../config"
request = require "request"

describe 'Loudr API', () ->
  describe 'Invalid User', () ->
    it "shouldn't find a user", (done) ->
      post_data = 
        form:
          email: "gerald.leenerts@gmail.com"
          password: "glee123"
        
      url = config.settings.api_host + ':' + config.settings.api_port + '/auth/login'

      request.post url, post_data, (err, resp, body) ->
        assert(!err)
        json = JSON.parse body

        assert.equal json.success, false
        done()