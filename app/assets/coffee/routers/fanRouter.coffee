define ["backbone", "marionette", "models/fanModel"], (Backbone, Marionette, FanCollection) ->

  class FanRouter extends Marionette.AppRouter
    controller:
      fan: (project_id) ->
        # TODO
    
    initialize: (options) ->
      @controller.app = options.app

    appRoutes:
      "project/:project_id/fan": "fan"

  return FanRouter