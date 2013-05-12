restify = require "restify"
mongoose = require "mongoose"
routes = require "./routes"
config = require "../config"

server = restify.createServer()
server.pre restify.pre.userAgentConnection()
server.use restify.bodyParser()

db = mongoose.connect config.settings.conn_str, (err) ->
  mongoose.connection.db.dropDatabase (err) ->
    console.log 'DropDB Error:', err

mongoose.connection.on "error", (errorObject) ->
  console.log 'Connection Error:', errorObject

Schema = mongoose.Schema

# Add Routes
routes.add(server)

server.listen 3001, ->
  console.log "%s listening at %s", server.name, server.url