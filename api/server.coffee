restify = require "restify"
routes = require "./routes"

server = restify.createServer()
server.pre restify.pre.userAgentConnection()

routes.site(server)

# Controllers Here
#siteController = require './controllers/site'

# Main Routes
# server.get "/", siteController.index

# Admin Routes

server.listen 3001, ->
  console.log "%s listening at %s", server.name, server.url