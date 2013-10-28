define ["backbone", "marionette", "loudr.config"], (Backbone, Marionette, LoudrConfig) ->

  class LoudrLogin extends Marionette.Layout
    initialize: (options) ->
      LoudrConfig.app.displayTitle "Login"

    events:
      "submit form": "attempt_login"

    template: "#login_template"

    attempt_login: (e) ->
      e.preventDefault()

      email = @.$('input[name="email"]').val()
      password = @.$('input[name="password"]').val()

      # Submit to auth model
      LoudrConfig.auth.login email, password, (success) ->
        if success
          Backbone.history.navigate '/', { trigger: true }
          return

  return LoudrLogin