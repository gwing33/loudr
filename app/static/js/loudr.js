(function() {
  define(['marionette', 'loudr.router', 'loudr.auth', 'loudr.login'], function(Marionette, LoudrRouter, LoudrAuth, LoudrLogin) {
    var Loudr;

    Loudr = new Marionette.Application();
    Loudr.addRegions({
      headerRegion: 'header',
      mainRegion: '#main'
    });
    Loudr.addInitializer(function() {
      return this.auth = new LoudrAuth();
    });
    Loudr.on('initialize:after', function() {
      this.router = new LoudrRouter({
        app: this
      });
      return Backbone.history.start({
        pushState: true,
        root: "/app/"
      });
    });
    return Loudr;
  });

}).call(this);
