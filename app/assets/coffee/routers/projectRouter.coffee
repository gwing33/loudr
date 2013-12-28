define [
  "backbone"
  "marionette"
  "loudr.config"
  "views/projectLayout"
  "models/fanModel"
  "views/fanList"
], (Backbone, Marionette, LoudrConfig, ProjectLayout, FanCollection, FanCollectionView) ->

  class ProjectRouter extends Marionette.AppRouter
    project_page_rendered: false

    layout: {}
    fan_collection_view: {}

    controller:
      project: (project_id, key) ->
        unless key?
          key = ''

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

    appRoutes:
      "project/:project_id/": "project"
      "project/:project_id/key/:key": "project"
      

  return ProjectRouter