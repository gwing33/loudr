(function() {
  define(['marionette', 'router', 'views/nav', 'models/auth', 'views/login'], function(Marionette, LoudrRouter, LoudrNav, LoudrAuth, LoudrLogin) {
    var Loudr;

    Loudr = new Marionette.Application();
    Loudr.addRegions({
      navRegion: '#main_nav',
      mainRegion: '#main'
    });
    Loudr.displayTitle = function(text) {
      return $('#page_header div').html(text);
    };
    Loudr.addInitializer(function() {
      this.auth = new LoudrAuth();
      this.nav_collection = new LoudrNav.Collection();
      return this.nav = new LoudrNav.Layout({
        collection: this.nav_collection
      });
    });
    Loudr.on('initialize:after', function() {
      this.router = new LoudrRouter({
        app: this
      });
      this.navRegion.show(this.nav);
      this.nav_collection.show_logged_in_nav();
      return Backbone.history.start({
        pushState: true,
        root: "/app/"
      });
    });
    return Loudr;
  });

}).call(this);
