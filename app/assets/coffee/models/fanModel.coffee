define ["backbone"], (Backbone) ->
  class FanModel extends Backbone.Model
    parse: (json) ->
      if json.success
        return json.fan
      
      return json

  class FanCollection extends Backbone.Collection
    project_id: ''
    key: ''
    model: FanModel
    
    url: () ->
      qs = if @key != '' then '?key=' + @key else ''
      return '/project/' + @project_id + '/fan/' + qs

    initialize: (models, options) ->
      @project_id = options.project_id
      @key = options.key

    parse: (json) ->
      return json.fans

  return FanCollection