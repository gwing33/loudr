(function() {
  define(['marionette', 'loudr.router', 'loudr.nav', 'loudr.auth', 'loudr.login'], function(Marionette, LoudrRouter, LoudrNav, LoudrAuth, LoudrLogin) {
    var Loudr;

    Loudr = new Marionette.Application();
    Loudr.addRegions({
      headerRegion: 'header',
      mainRegion: '#main'
    });
    Loudr.addInitializer(function() {
      this.auth = new LoudrAuth();
      return this.nav = new LoudrNav({
        app: this
      });
    });
    Loudr.on('initialize:after', function() {
      this.router = new LoudrRouter({
        app: this
      });
      this.headerRegion.show(this.nav);
      return Backbone.history.start({
        pushState: true,
        root: "/app/"
      });
    });
    return Loudr;
  });

}).call(this);
