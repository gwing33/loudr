define ["marionette"], (Marionette) ->

  class LoudrLogin extends Marionette.Layout
    initialize: (options) ->
      @app = options.app

    events:
      "submit form": "attempt_login"

    template: "#login_template"

    attempt_login: (e) ->
      e.preventDefault()

      email = @.$('input[name="email"]').val()
      password = @.$('input[name="password"]').val()

      # Submit to auth model
      $this = @
      @app.auth.login email, password, (success) ->

        if success
          $this.app.router.navigate '/',
            trigger: true
          return

  return LoudrLogin