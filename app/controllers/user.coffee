config = require "../../config"
request = require "request"

api_url = config.settings.api_host + ':' + config.settings.api_port

exports.login = (req, res) ->
  post_data = 
    form:
      email: req.body.email
      password: req.body.password

  request.post api_url + '/auth/login', post_data, (err, resp, body) ->
    res.send 'error' if err

    res.send body

exports.logout = (req, res) ->
  request.get api_url + '/auth/logout', (err, resp, body) ->
    res.send body

# connect = require('connect')
# RedisStore = require('connect-redis')(connect);

# RedisSessionStore ?= require('connect-redis')(express)
# redisSessionStore ?= new RedisSessionStore(
#     host: appConfig.databaseRedis.host
#     port: appConfig.databaseRedis.port
#     db: appConfig.databaseRedis.username
#     pass: appConfig.databaseRedis.password
#     no_ready_check: true
#     ttl: 60*60  # hour
# )
# server.use express.session({
#     secret: appConfig.site.salt
#     cookie: maxAge: 1000*60*60
#     store: redisSessionStore
# })