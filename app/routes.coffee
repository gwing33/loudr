exports.add = (app) ->
  site_controller = require './controllers/site'

  app.get "/", site_controller.index
  app.get /^(\/app){1}(.*)$/, site_controller.app