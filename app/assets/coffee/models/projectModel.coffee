define ["backbone"], (Backbone) ->

  class ProjectModel extends Backbone.Model
    parse: (json) ->
      if json.success
        return json.project
      
      return json

  class ProjectCollection extends Backbone.Collection
    model: ProjectModel
    url: '/project'
    parse: (json) ->
      return json.projects

  return ProjectCollection