(function() {
  define(['marionette', 'routers/dashboardRouter', 'routers/projectRouter', 'routers/fanRouter', 'views/nav', 'models/auth'], function(Marionette, DashboardRouter, ProjectRouter, FanRouter, LoudrNav, LoudrAuth) {
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
      return this.nav = new LoudrNav.Layout({
        collection: new LoudrNav.Collection()
      });
    });
    Loudr.on('initialize:after', function() {
      this.routers = {};
      this.routers.dash = new DashboardRouter({
        app: this
      });
      this.routers.project = new ProjectRouter({
        app: this
      });
      this.routers.fan = new FanRouter({
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
