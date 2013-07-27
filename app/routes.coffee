exports.add = (app) ->
  site_controller = require './controllers/site'
  user_controller = require './controllers/user'
  project_controller = require './controllers/project'
  docs_controller = require './controllers/docs'

  app.get "/", site_controller.index
  app.get /^(\/app){1}(.*)$/, site_controller.app

  app.post "/login", user_controller.login
  app.get "/logout", user_controller.logout

  app.get "/project", project_controller.index
  app.post "/project", project_controller.create

  app.get "/docs", docs_controller.index