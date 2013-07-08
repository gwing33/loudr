exports.add = (app) ->
  site_controller = require './controllers/site'
  user_controller = require './controllers/user'
  dashboard_controller = require './controllers/dashboard'

  app.get "/", site_controller.index
  app.get /^(\/app){1}(.*)$/, site_controller.app

  app.post "/login", user_controller.login
  app.get "/logout", user_controller.logout

  app.get "/dashboard", dashboard_controller.index