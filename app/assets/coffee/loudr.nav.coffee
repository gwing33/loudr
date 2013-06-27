define ["marionette"], (Marionette) ->
  LoudrNav = Marionette.Layout.extend
    initialize: (options) ->
      @app = options.app

    template: "#nav_template"

  return LoudrNav