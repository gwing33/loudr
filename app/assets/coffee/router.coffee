define ["marionette", "views/dashboard", "views/login"], (Marionette, DashboardView, LoudrLogin) ->
  class LoudrRouter extends Marionette.AppRouter
    controller:
      home: () ->
        $this = @
        # Load Dashboard
        dash = new DashboardView.Layout
          app: $this.app

        dash_collection = new DashboardView.Collection

        dash_collection_view = new DashboardView.CollectionView
          collection: dash_collection
        
        dash_collection.fetch
          error: (err, blah, doh) ->
            $this.app.router.navigate 'login', {trigger: true} if doh.xhr.status == 401

        $this.app.mainRegion.show dash
        dash.projectsRegion.show dash_collection_view

      project: (project_id) ->
        console.log project_id

      login: () ->
        login = new LoudrLogin
          app: @app
        @app.mainRegion.show login

      logout: () ->
        $this = @
        @app.auth.logout () ->
          $this.app.router.navigate 'login', {trigger: true}



    initialize: (options) ->
      @controller.app = options.app

    appRoutes:
      "": "home"
      "project/:project_id": "project"
      "login": "login"
      "logout": "logout"

  return LoudrRouter