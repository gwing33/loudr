define ["marionette"], (Marionette) ->

  LoudrLogin = Marionette.Layout.extend
    initialize: (options) ->
      @app = options.app

    events:
      "submit form": "attempt_login"

    template: "#login_template"

    attempt_login: (e) ->
      e.preventDefault()

      email = @.$('input[name="email"]').val()
      password = @.$('input[name="password"]').val()

      console.log email, password

      # Submit to auth model
      @app.auth.login email, password

  return LoudrLogin