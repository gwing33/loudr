restify = require("restify")
server = restify.createServer(
  name: "loudr"
  version: "1.0.0"
)
server.use restify.acceptParser(server.acceptable)
server.use restify.queryParser()
server.use restify.bodyParser()
server.get "/echo/:name", (req, res, next) ->
  res.send req.params
  next()

server.listen 8080, ->
  console.log "%s listening at %s", server.name, server.url