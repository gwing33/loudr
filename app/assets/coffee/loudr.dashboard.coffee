define ["marionette"], (Marionette) ->
  class LoudrDashboard extends Marionette.Layout
    initialize: (options) ->
      @app = options.app

    template: "#dashboard_template"

  return LoudrDashboard