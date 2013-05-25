# This file maps your route matches
# to functions defined in various
# controller classes
exports.add = (server) ->
  # Define Controllers
  site_controller = require './controllers/site'
  user_controller = require './controllers/user'
  project_controller = require './controllers/project'

  # Define Routes
  server.get '/', site_controller.index

  server.post '/auth/login', user_controller.login

  server.get '/user/:email', user_controller.get_user
  server.post '/user/', user_controller.create_user
  server.put '/user/:id', user_controller.update_user
  server.del '/user/:id', user_controller.delete_user
  # server.get '/user/:email', user_controller.get_by_email

  server.get '/project/:id', project_controller.get_project
