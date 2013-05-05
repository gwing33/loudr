restify = require "restify"
mongoose = require "mongoose"
routes = require "./routes"
config = require "../config"

server = restify.createServer()
server.pre restify.pre.userAgentConnection()
server.use restify.bodyParser()

db = mongoose.connect config.settings.conn_str
Schema = mongoose.Schema

# Add Routes
routes.add(server)

server.listen 3001, ->
  console.log "%s listening at %s", server.name, server.url