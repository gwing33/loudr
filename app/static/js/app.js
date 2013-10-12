(function() {
  require.config({
    paths: {
      backbone: 'vendor/backbone',
      'backbone.queryparams': 'vendor/backbone.queryparams',
      underscore: 'vendor/underscore',
      jquery: 'vendor/jquery-1.10.2.min',
      marionette: 'vendor/backbone.marionette',
      'backbone.wreqr': 'vendor/backbone.wreqr',
      'backbone.babysitter': 'vendor/backbone.babysitter'
    },
    shim: {
      jquery: {
        exports: 'jQuery'
      },
      underscore: {
        exports: '_'
      },
      backbone: {
        deps: ['jquery', 'underscore'],
        exports: 'Backbone'
      }
    }
  });

  define(['loudr', 'loudr.config'], function(Loudr, LoudrConfig) {
    LoudrConfig.app = Loudr;
    return LoudrConfig.app.start();
  });

}).call(this);
