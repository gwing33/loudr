# This file maps your route matches
# to functions defined in various
# controller classes
exports.add = (server) ->
  # Define Controllers
  site_controller = require './controllers/site'
  user_controller = require './controllers/user'
  project_controller = require './controllers/project'
  fan_controller = require './controllers/fan'
  notification_controller = require './controllers/notification'

  # Define Routes
  server.get '/', site_controller.index

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
  
  # Fans - I use "app" here instead of project to shorten urls
  server.get '/app/fan/:id', fan_controller.get_fan
  server.post '/app/fan', fan_controller.create_fan
  server.put '/app/fan/:id', fan_controller.update_fan
  server.del '/app/fan/:id', fan_controller.delete_fan

  server.get '/app/:key/fan/', fan_controller.get_all_fans
  server.get '/app/:key/fan/:email', fan_controller.get_fan_by_email
  server.put '/app/:key/fan/:email', fan_controller.update_fan_by_email


  # Fan Notifications
  server.get '/app/fan/:fan_id/note', notification_controller.get_all_notes
  server.get '/app/fan/:fan_id/note/:id', notification_controller.get_note
  server.post '/app/fan/:fan_id/note', notification_controller.create_note
  server.put '/app/fan/:fan_id/note/:id', notification_controller.update_note
  server.del '/app/fan/:fan_id/note/:id', notification_controller.delete_note

  server.get '/app/:key/fan/:email/note', notification_controller.get_all_notes_by_email
  server.get '/app/:key/fan/:email/note/:id', notification_controller.get_note_by_email
  server.post '/app/:key/fan/:email/note', notification_controller.create_note_by_email
  server.put '/app/:key/fan/:email/note/:id', notification_controller.update_note_by_email
  server.del '/app/:key/fan/:email/note/:id', notification_controller.delete_note_by_email