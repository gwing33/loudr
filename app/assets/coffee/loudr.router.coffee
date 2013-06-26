define ["marionette", "loudr.login"], (Marionette, LoudrLogin) ->
  LoudrRouter = Marionette.AppRouter.extend
    controller:
      home: () ->
        @app.router.navigate 'login', {trigger: true} unless @app.auth.is_authed()
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