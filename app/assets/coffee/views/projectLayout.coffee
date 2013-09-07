define ["marionette"], (Marionette) ->

  class LoudrProject extends Marionette.Layout
    template: "#project_fans_template"
    regions:
      fansRegion: '#fan_list'

    initialize: (options) ->
      @app = options.app

  return LoudrProject