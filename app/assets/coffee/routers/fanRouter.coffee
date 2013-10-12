define ["backbone", "marionette", "loudr.config", "models/fanModel"], (Backbone, Marionette, LoudrConfig, FanCollection) ->

  class FanRouter extends Marionette.AppRouter
    controller:
      fan: (project_id) ->
        console.log project_id
        # TODO
      
      get_fan: (project_id, id) ->
        console.log project_id, id

    appRoutes:
      "project/:project_id/fan": "fan"
      "project/:project_id/fan/:id": "fan"

  return FanRouter