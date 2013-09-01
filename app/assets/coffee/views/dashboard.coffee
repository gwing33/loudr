define ["marionette"], (Marionette) ->

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

  class LoudrProjectItem extends Marionette.ItemView
    tagName: 'li'
    template: "#project_list_template"

  # I left it as 'LoudrDashboard' because it's the landing page.
  # There could be more things than just a list of projects.
  class LoudrProjectCollectionView extends Marionette.CollectionView
    tagName: 'ul'
    itemView: LoudrProjectItem

  class LoudrDashboard extends Marionette.Layout
    template: "#dashboard_template"
    regions:
      projectsRegion: '#project_list'

    initialize: (options) ->
      @app = options.app
      @app.displayTitle "Select a Project"

    events:
      'submit form': 'new_project',
      'click a': 'open_project'

    open_project: (e) ->
      e.preventDefault()
      @app.router.navigate $(e.currentTarget).attr('href'), {trigger: true}

    new_project: (e) ->
      e.preventDefault()

      @projectsRegion.currentView.collection.create { name: @$('#project_name').val() }, 
        wait: true
        success: (json) ->
          # Reset Value
          @$('#project_name').val ''
        error: (grr, blah, doh) ->
          # TODO
          console.log grr, blah, doh

  return {
    Collection: LoudrProjectCollection
    CollectionView: LoudrProjectCollectionView
    Layout: LoudrDashboard
  }