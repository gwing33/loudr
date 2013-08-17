# restify = require "restify"
express = require "express"
mongoose = require "mongoose"
routes = require "./routes"
config = require "../config"

RedisStore = require("connect-redis")(express)
# redis = require("redis").createClient()

server = express()
server.set "ipaddr", process.env.OPENSHIFT_NODEJS_IP or "127.0.0.1"
server.set "port", 15001

server.use express.bodyParser()
server.use express.cookieParser()
server.use express.session
  secret: "s3cr3ts3cr3t1v3g0t4s3cr3t"
  store: new RedisStore config.settings.redis

db = mongoose.connect config.settings.conn_str
  # , (err) ->
  # mongoose.connection.db.dropDatabase (err) ->
  #   console.log 'DropDB Error:', err if err?

mongoose.connection.on "error", (errorObject) ->
  console.log 'Connection Error:', errorObject

Schema = mongoose.Schema

# Add Routes
routes.add server

server.listen server.get("port"),server.get("ipaddr"), ()->
  console.log "API server listening on port " + server.get("port")