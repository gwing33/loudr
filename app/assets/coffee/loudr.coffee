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

define ["marionette"], (Marionette) ->
  # set up the app instance
  LoudrApp = new Marionette.Application()
  console.log LoudrApp
  # configuration, setting up regions, etc ...

  # export the app from this module
  return LoudrApp