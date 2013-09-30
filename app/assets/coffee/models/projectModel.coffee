define ["backbone"], (Backbone) ->

  class LoudrProjectModel extends Backbone.Model
    parse: (json) ->
      if json.success
        return json.project
      
      return json

  class LoudrProjectCollection extends Backbone.Collection
    model: LoudrProjectModel
    url: '/project'
    parse: (json) ->
      return json.projects

  return LoudrProjectCollection