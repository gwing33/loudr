(function() {
  require.config({
    paths: {
      backbone: 'vendor/backbone',
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

  define(['loudr'], function(Loudr) {
    return Loudr.start();
  });

}).call(this);
