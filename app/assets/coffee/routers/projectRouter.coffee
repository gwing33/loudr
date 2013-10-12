define ["backbone", "marionette", "loudr.config", "views/projectLayout", "models/fanModel", "views/fanList"], (Backbone, Marionette, LoudrConfig, ProjectLayout, FanCollection, FanCollectionView) ->

  class ProjectRouter extends Marionette.AppRouter
    project_page_rendered: false,

    layout: {},
    fan_collection_view: {}

    controller:
      project: (project_id, params) ->
        key = ''
        if params? and params.key
          key = params.key

        @project_page_rendered = true

        @layout = new ProjectLayout
          project_id: project_id

        fan_collection = new FanCollection [],
          project_id: project_id
          key: key

        @fan_collection_view = new FanCollectionView
          collection: fan_collection

        fan_collection.fetch
          error: (obj, err, doh) ->
            # If they aren't logged in
            Backbone.history.navigate 'login', {trigger: true}  if doh.xhr.status == 401

        LoudrConfig.app.mainRegion.show @layout
        @layout.fansRegion.show @fan_collection_view

      new_note: (project_id) ->
        @project(project_id)  unless @project_page_rendered
        
        console.log 'new note via controller...'

    appRoutes:
      "project/:project_id/": "project"
      "project/:project_id/note": "new_note"
      

  return ProjectRouter