respond = (req, res, next) ->
  res.send "hello " + req.params.name

# Look into socket.io

restify = require("restify")
server = restify.createServer()
server.get "/hello/:name", respond
server.head "/hello/:name", respond
server.pre restify.pre.userAgentConnection()

server.listen 8080, ->
  console.log "%s listening at %s", server.name, server.url