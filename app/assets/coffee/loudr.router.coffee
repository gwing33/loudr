define ["marionette", "loudr.dashboard", "loudr.login"], (Marionette, LoudrDashboard, LoudrLogin) ->
  LoudrRouter = Marionette.AppRouter.extend
    controller:
      home: () ->
        # Load dashboard

        # @app.router.navigate 'login', {trigger: true} unless @app.auth.is_authed()

        dash = new LoudrDashboard
          app: @app
        
        @app.mainRegion.show dash

      login: () ->
        login = new LoudrLogin
          app: @app
        @app.mainRegion.show login

    initialize: (options) ->
      @controller.app = options.app

    appRoutes:
      "": "home"
      "login": "login"

  return LoudrRouter