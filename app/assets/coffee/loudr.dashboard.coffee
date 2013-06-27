define ["marionette"], (Marionette) ->
  LoudrDashboard = Marionette.Layout.extend
    initialize: (options) ->
      @app = options.app

    template: "#dashboard_template"

  return LoudrDashboard