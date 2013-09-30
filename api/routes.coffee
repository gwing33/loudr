# This file maps your route matches
# to functions defined in various
# controller classes
exports.add = (server) ->
  # Define Controllers
  user_controller = require './controllers/user'
  project_controller = require './controllers/project'
  fan_controller = require './controllers/fan'
  notification_controller = require './controllers/notification'

  # # # Define Routes # # #

  # Authing
  server.post '/auth/login', user_controller.login


  # Users
  server.get '/user', user_controller.get_all_users
  server.get '/user/:id', user_controller.get_user
  server.post '/user', user_controller.create_user
  server.put '/user/:id', user_controller.update_user
  server.del '/user/:id', user_controller.delete_user

  # Projects
  server.get '/user/:user_id/project', project_controller.get_all
  server.get '/user/:user_id/project/:id', project_controller.get_by_id
  server.post '/user/:user_id/project', project_controller.create_project
  server.put '/user/:user_id/project/:id', project_controller.update_project
  server.del '/user/:user_id/project/:id', project_controller.delete_project

  # This will generate a usable hash for the project
  server.get '/get/auth/hash/:project_id', project_controller.generate_hash
  server.get '/get/auth/hash/:project_id/:date', project_controller.generate_hash_date
  
  # Fans
  server.get '/project/:project_id/fan/', fan_controller.get_all_fans
  server.post '/project/:project_id/fan/', fan_controller.create_fan
  server.get '/project/:project_id/fan/:fan_handle', fan_controller.get_fan
  server.put '/project/:project_id/fan/:fan_handle', fan_controller.update_fan
  server.del '/project/:project_id/fan/:fan_handle', fan_controller.delete_fan

  # Fan Notifications
  server.get '/project/:project_id/fan/:fan_handle/note', notification_controller.get_all_notes
  server.get '/project/:project_id/fan/:fan_handle/note/:id', notification_controller.get_note
  server.post '/project/:project_id/fan/:fan_handle/note', notification_controller.create_note
  server.put '/project/:project_id/fan/:fan_handle/note/:id', notification_controller.update_note
  server.del '/project/:project_id/fan/:fan_handle/note/:id', notification_controller.delete_note

  # Fan Script Notification Calls
  server.get '/p/:project_id/f/:fan_handle', notification_controller.unsecure_all_notes
  server.get '/p/:project_id/h/:hash/:date/f/:fan_handle', notification_controller.secure_all_notes