define ["marionette"], (Marionette) ->
  class LoudrFanModel extends Backbone.Model
    parse: (json) ->
      if json.success
        return json.fan
      
      return json


  class LoudrFanCollection extends Backbone.Collection
    project_id: ''
    model: LoudrFanModel
    url: () ->
      return '/fan/' + @project_id

    initialize: (models, options) ->
      @project_id = options.project_id

    parse: (json) ->
      return json.fans

  return LoudrFanCollection