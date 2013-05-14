# Manuall Run via: `mocha tests/user-test.coffee --compilers coffee:coffee-script --reporter Spec`
assert = require "assert"
should = require "should"
config = require "../config"
request = require "request"
mongoose = require "mongoose"
User = require "../api/models/usersModel"

# db = mongoose.connect config.settings.conn_str
api_url = config.settings.api_host + ':' + config.settings.api_port

describe 'User App API', () ->
  it "should do a test", () ->
    assert.equal true, true