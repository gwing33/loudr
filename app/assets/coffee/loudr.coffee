# Configure Require
require.config
  paths:
    backbone: '/js/vendor/backbone'
    underscore: '/js/vendor/underscore'
    jquery: '/js/vendor/jquery-1.9.1.min'
    marionette: '/js/vendor/backbone.marionette'
    'backbone.wreqr': '/js/vendor/backbone.wreqr'
    # 'backbone.eventbinder': '/js/vendor/backbone.eventbinder'
    'backbone.babysitter': '/js/vendor/backbone.babysitter'
  shim:
    jquery:
      exports: 'jQuery'
    underscore:
      exports: '_'
    backbone:
      deps: ['jquery', 'underscore']
      exports: 'Backbone'

# Include Marionette, which will include everything else
define ["marionette"], (Marionette) ->
  Loudr = new Marionette.Application()

  # configuration, setting up regions, etc ...
  Loudr.addRegions
    headerRegion: 'header'
    mainRegion: '#main'
    footerRegion: 'footer'

  Loudr.on 'initialize:after', () ->
    Backbone.history.start()

  Loudr.start()

  # export the app from this module
  return Loudr