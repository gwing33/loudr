express  = require "express"
mongoose = require "mongoose"
config   = require "../config"

# Controllers
user_controller         = require './controllers/user'
project_controller      = require './controllers/project'
fan_controller          = require './controllers/fan'
notification_controller = require './controllers/notification'

# Auth Helper
Auth = require "./helpers/_auth"

RedisStore = require("connect-redis")(express)

server = express()
server.set "ipaddr", process.env.OPENSHIFT_NODEJS_IP or "127.0.0.1"
server.set "port", config.settings.api_port

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
  console.log 'API DB Connection Error:', errorObject

Schema = mongoose.Schema

# Add Routes
# Authing
server.post '/auth/login', user_controller.login

# Authing...
authAPI = (req, res, next) ->


# Users
server.get '/user', Auth.loudrValidateReq, user_controller.get_all_users
server.get '/user/:id', Auth.loudrValidateReq, user_controller.get_user
server.post '/user', Auth.loudrValidateReq, user_controller.create_user
server.put '/user/:id', Auth.loudrValidateReq, user_controller.update_user
server.del '/user/:id', Auth.loudrValidateReq, user_controller.delete_user

# Projects
server.get '/user/:user_id/project', Auth.loudrValidateReq, project_controller.get_all
server.get '/user/:user_id/project/:id', Auth.validateRequest, project_controller.get_by_id
server.post '/user/:user_id/project', Auth.loudrValidateReq, project_controller.create_project
server.put '/user/:user_id/project/:id', Auth.validateRequest, project_controller.update_project
server.del '/user/:user_id/project/:id', Auth.validateRequest, project_controller.delete_project

# This will generate a usable hash for the project
server.get '/get/auth/hash/:project_id', project_controller.generate_hash
server.get '/get/auth/hash/:project_id/:date', project_controller.generate_hash_date

# Fans
server.get '/project/:project_id/fan/', Auth.validateRequest, fan_controller.get_all_fans
server.post '/project/:project_id/fan/', Auth.validateRequest, fan_controller.create_fan
server.get '/project/:project_id/fan/:fan_handle', Auth.validateRequest, fan_controller.get_fan
server.put '/project/:project_id/fan/:fan_handle', Auth.validateRequest, fan_controller.update_fan
server.del '/project/:project_id/fan/:fan_handle', Auth.validateRequest, fan_controller.delete_fan

# Fan Notifications
server.get '/project/:project_id/fan/:fan_handle/note', Auth.validateRequest, notification_controller.get_all_notes
server.get '/project/:project_id/fan/:fan_handle/note/:id', Auth.validateRequest, notification_controller.get_note
server.post '/project/:project_id/fan/:fan_handle/note', Auth.validateRequest, notification_controller.create_note
server.put '/project/:project_id/fan/:fan_handle/note/:id', Auth.validateRequest, notification_controller.update_note
server.del '/project/:project_id/fan/:fan_handle/note/:id', Auth.validateRequest, notification_controller.delete_note

# Fan Script Notification Calls
server.get '/p/:project_id/f/:fan_handle', notification_controller.unsecure_all_notes
server.get '/p/:project_id/h/:hash/:date/f/:fan_handle', notification_controller.secure_all_notes


# Start listening to the port.
server.listen server.get("port"),server.get("ipaddr"), ()->
  console.log "API server listening on port " + server.get("port")