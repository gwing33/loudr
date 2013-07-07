(function() {
  define(['marionette', 'loudr.router', 'loudr.nav', 'loudr.auth', 'loudr.login'], function(Marionette, LoudrRouter, LoudrNav, LoudrAuth, LoudrLogin) {
    var Loudr;

    Loudr = new Marionette.Application();
    Loudr.addRegions({
      navRegion: 'header nav',
      mainRegion: '#main'
    });
    Loudr.addInitializer(function() {
      this.auth = new LoudrAuth();
      this.nav_collection = new LoudrNav.Collection();
      this.nav_collection.add({
        name: 'messages',
        src: '#'
      });
      return this.nav = new LoudrNav.Layout({
        collection: this.nav_collection
      });
    });
    Loudr.on('initialize:after', function() {
      this.router = new LoudrRouter({
        app: this
      });
      this.navRegion.show(this.nav);
      return Backbone.history.start({
        pushState: true,
        root: "/app/"
      });
    });
    return Loudr;
  });

}).call(this);
