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

  # Test Seeds, Remove after Development
  server.get '/seed', site_controller.seed

  # Authing
  server.get '/authed', user_controller.authed
  server.post '/auth/login', user_controller.login
  server.get '/auth/logout', user_controller.logout

  # User Routes
  server.get '/user/:email', user_controller.get_user
  server.post '/user', user_controller.create_user
  server.put '/user/:id', user_controller.update_user
  server.del '/user/:id', user_controller.delete_user

  # Projects
  server.get '/project', project_controller.get_all
  server.get '/project/:id', project_controller.get_by_id
  server.post '/project', project_controller.create_project
  server.put '/project/:id', project_controller.update_project
  server.del '/project/:id', project_controller.delete_project
  server.del '/project/confirm/:id', project_controller.delete_project
  server.del '/project/disable/:id', project_controller.disable_project
  server.get '/project/enable/:id', project_controller.enable_project
  
  # Fans
  # I use "app" here instead of project because urls will be longer,
  # it might make more sense to do "project" but for now, it's good.
  server.get '/app/:key/fans/', fan_controller.get_all_fans
  server.get '/app/:key/fan/:email', fan_controller.get_fan_by_email
  server.post '/app/:key/fan', fan_controller.create_fan
  server.put '/app/:key/fan/:email', fan_controller.update_fan
  server.del '/app/:key/fan/:email', fan_controller.delete_fan

  # Fan Notifications
  server.get '/app/:key/fan/:email/notifications', notification_controller.get_all
  server.get '/app/:key/fan/:email/notification/:id', notification_controller.get_by_id
  server.post '/app/:key/fan/:email/notification', notification_controller.create_notification
  server.put '/app/:key/fan/:email/notification/:id', notification_controller.update_notification
  server.del '/app/:key/fan/:email/notification/:id', notification_controller.delete_notification