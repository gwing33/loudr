express = require "express"
http    = require "http"
path    = require "path"
config  = require "./config"

site_controller    = require './app/controllers/site'
user_controller    = require './app/controllers/user'
project_controller = require './app/controllers/project'
fan_controller     = require './app/controllers/fan'
docs_controller    = require './app/controllers/docs'

RedisStore = require("connect-redis")(express)

# Create the app variable
app = express()

# all environments
app.set "ipaddr", process.env.OPENSHIFT_NODEJS_IP or "127.0.0.1"
app.set "port", process.env.OPENSHIFT_NODEJS_PORT or 3000
app.set "views", __dirname + "/app/views"
app.set "view engine", "ejs"

app.use express.favicon()
app.use express.logger("dev")
app.use express.bodyParser()
app.use express.methodOverride()
app.use express.cookieParser()
app.use express.session
  secret: "s3cr3ts3cr3t1v3g0t4s3cr3t"
  store: new RedisStore config.settings.redis

# Auth Function, just make sure they are logged in.
auth = (req, res, next) ->
  return res.status(401).send() unless req.session.user?
  next()

app.use app.router
app.use express.static path.join(__dirname, "app/static")

# development only
app.use express.errorHandler()  if "development" is app.get("env")

# Do Login check here...
app.get "/", site_controller.index
app.get /^(\/app){1}(.*)$/, site_controller.app

app.post "/register", user_controller.register
app.post "/login", user_controller.login
app.get "/logout", user_controller.logout

app.get "/project", auth, project_controller.index
app.post "/project", auth, project_controller.create

app.get "/project/:project_id/fan", auth, fan_controller.index

app.get "/docs", docs_controller.index
app.get "/docs/:page", docs_controller.index
app.get "/docs/partial/:page", docs_controller.render_partial_md

# Just log what port I'm on...
console.log "awesome port is:", app.get "port"

http.createServer(app).listen app.get("port"), app.get("ipaddr"), ->
  console.log "APP server listening on port " + app.get("port")