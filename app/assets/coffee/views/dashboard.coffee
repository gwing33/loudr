define ["marionette"], (Marionette) ->

  class LoudrProjectModel extends Backbone.Model

  class LoudrProjectCollection extends Backbone.Collection
    model: LoudrProjectModel
    url: '/project'

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

    events:
      'submit form': 'new_project',
      'click a': 'open_project'

    open_project: (e) ->
      e.preventDefault()
      
      # Unload Collection
      # Load in Project view

    new_project: (e) ->
      e.preventDefault()

      @projectsRegion.currentView.collection.create
        name: @$('#project_name').val()

  return {
    Collection: LoudrProjectCollection
    CollectionView: LoudrProjectCollectionView
    Layout: LoudrDashboard
  }