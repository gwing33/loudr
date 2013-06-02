exports.add = (app) ->
  site_controller = require './controllers/site'

  app.get "/", site_controller.index