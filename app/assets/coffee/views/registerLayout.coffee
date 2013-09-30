define ["backbone", "marionette"], (Backbone, Marionette) ->

  class LoudrRegister extends Marionette.Layout
    initialize: (options) ->
      @app = options.app

    events:
      "submit form": "attempt_register"

    template: "#register_template"

    attempt_register: (e) ->
      e.preventDefault()

      full_name = @.$('input[name="full_name"]').val()
      email = @.$('input[name="email"]').val()
      password = @.$('input[name="password"]').val()

      # Submit to auth model
      $this = @
      @app.auth.register full_name, email, password, (success) ->
        if success
          Backbone.history.navigate '/', { trigger: true }
          return

  return LoudrRegister