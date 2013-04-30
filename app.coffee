###
Module dependencies.
###

express = require "express"
routes = require "./app/routes"
user = require "./app/routes/user"
http = require "http"
path = require "path"

app = express()

# all environments
app.set "port", process.env.PORT or 3000
app.set "views", __dirname + "/app/views"
app.set "view engine", "ejs"

app.use express.favicon()
app.use express.logger("dev")
app.use express.bodyParser()
app.use express.methodOverride()
app.use express.cookieParser("loudr")
app.use express.session()
app.use app.router
app.use express.static path.join(__dirname, "app/static")

# development only
app.use express.errorHandler()  if "development" is app.get("env")

app.get "/", routes.index
app.get "/users", user.list

http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")