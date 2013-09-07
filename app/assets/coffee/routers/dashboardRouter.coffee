define ["backbone", "marionette", "views/dashboardLayout", "models/projectModel", "views/projectList", "views/loginLayout", "views/registerLayout"], (Backbone, Marionette, DashboardLayout, ProjectCollection, ProjectCollectionView, LoginLayout, RegisterLayout) ->

  class DashboardRouter extends Marionette.AppRouter
    controller:
      home: () ->
        $this = @
        
        # Load Dashboard
        dash = new DashboardLayout()

        project_collection = new ProjectCollection

        project_collection_view = new ProjectCollectionView
          collection: project_collection
        
        project_collection.fetch
          error: (err, blah, doh) ->
            # If they aren't logged in
            Backbone.history.navigate 'login', {trigger: true} if doh.xhr.status == 401

            # Other Error...
            # TODO

        $this.app.mainRegion.show dash
        dash.projectsRegion.show project_collection_view

      register: () ->
        login = new RegisterLayout
          app: @app
        @app.mainRegion.show login

      login: () ->
        login = new LoginLayout
          app: @app
        @app.mainRegion.show login
        @app.nav.collection.show_logged_out_nav()

      logout: () ->
        $this = @
        @app.auth.logout () ->
          Backbone.history.navigate 'login', {trigger: true}

    initialize: (options) ->
      @controller.app = options.app

    appRoutes:
      "": "home"
      "register": "register"
      "login": "login"
      "logout": "logout"

  return DashboardRouter