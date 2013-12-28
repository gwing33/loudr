# Configure Require
require.config
  paths:
    backbone: 'vendor/backbone'
    underscore: 'vendor/underscore'
    jquery: 'vendor/jquery-2.0.3'
    marionette: 'vendor/backbone.marionette'
    'backbone.wreqr': 'vendor/backbone.wreqr'
    'backbone.babysitter': 'vendor/backbone.babysitter'
  shim:
    jquery:
      exports: 'jQuery'
    underscore:
      exports: '_'
    backbone:
      deps: ['jquery', 'underscore']
      exports: 'Backbone'

# Loudr will pull in needed applications
define ['loudr', 'loudr.config'], (Loudr, LoudrConfig) ->
  LoudrConfig.app = Loudr
  LoudrConfig.app.start()