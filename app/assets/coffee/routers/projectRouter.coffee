define ["backbone", "marionette", "views/projectLayout", "models/fanModel", "views/fanList"], (Backbone, Marionette, ProjectLayout, FanCollection, FanCollectionView) ->

  class ProjectRouter extends Marionette.AppRouter
    controller:
      project: (project_id) ->
        $this = @

        layout = new ProjectLayout
          app: $this.app

        fan_collection = new FanCollection [],
          project_id: project_id

        fan_collection_view = new FanCollectionView
          collection: fan_collection

        fan_collection.fetch
          error: (obj, err, doh) ->
            # If they aren't logged in
            Backbone.history.navigate 'login', {trigger: true} if doh.xhr.status == 401

        $this.app.mainRegion.show layout
        layout.fansRegion.show fan_collection_view

    initialize: (options) ->
      @controller.app = options.app

    appRoutes:
      "project/:project_id": "project"

  return ProjectRouter