(function() {
  define(['marionette', 'routers/dashboardRouter', 'routers/projectRouter', 'views/nav', 'models/auth'], function(Marionette, DashboardRouter, ProjectRouter, LoudrNav, LoudrAuth) {
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
      var nav_collection;

      this.auth = new LoudrAuth();
      nav_collection = new LoudrNav.Collection();
      return this.nav = new LoudrNav.Layout({
        collection: nav_collection
      });
    });
    Loudr.on('initialize:after', function() {
      this.router = {};
      this.router.dash = new DashboardRouter({
        app: this
      });
      this.router.project = new ProjectRouter({
        app: this
      });
      this.navRegion.show(this.nav);
      this.nav.collection.show_logged_in_nav();
      return Backbone.history.start({
        pushState: true,
        root: "/app/"
      });
    });
    return Loudr;
  });

}).call(this);
