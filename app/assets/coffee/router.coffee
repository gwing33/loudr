define ["marionette", "models/dashboard", "views/dashboard", "views/login"], (Marionette, DashboardModel, DashboardView, LoudrLogin) ->
  class LoudrRouter extends Marionette.AppRouter
    controller:
      home: () ->
        $this = @
        # Load Dashboard
        dash_model = new DashboardModel()
        dash_model.init (err, json) ->
          return $this.app.router.navigate 'login', {trigger: true} if err
          
          dash = new DashboardView
            app: $this.app

          $this.app.mainRegion.show dash

      login: () ->
        login = new LoudrLogin
          app: @app
        @app.mainRegion.show login

      logout: () ->
        console.log 'logging out'
        $this = @
        @app.auth.logout () ->
          $this.app.router.navigate 'login', {trigger: true}



    initialize: (options) ->
      @controller.app = options.app

    appRoutes:
      "": "home"
      "login": "login"
      "logout": "logout"

  return LoudrRouter