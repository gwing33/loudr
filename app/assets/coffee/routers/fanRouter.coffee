define ["backbone", "marionette", "models/fanModel"], (Backbone, Marionette, FanCollection) ->

  class FanRouter extends Marionette.AppRouter
    controller:
      create_fan: (project_id) ->
        # TODO
    
    initialize: (options) ->
      @controller.app = options.app

    appRoutes:
      "project/:project_id/fan": "create_fan"

  return FanRouter