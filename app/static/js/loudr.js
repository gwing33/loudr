(function() {
  define(['marionette', 'loudr.config', 'routers/dashboardRouter', 'routers/projectRouter', 'routers/fanRouter', 'views/nav', 'models/auth'], function(Marionette, LoudrConfig, DashboardRouter, ProjectRouter, FanRouter, LoudrNav, LoudrAuth) {
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
      LoudrConfig.auth = new LoudrAuth();
      return LoudrConfig.nav = new LoudrNav.Layout({
        collection: new LoudrNav.Collection()
      });
    });
    Loudr.on('initialize:after', function() {
      LoudrConfig.routers.dash = new DashboardRouter();
      LoudrConfig.routers.project = new ProjectRouter();
      LoudrConfig.routers.fan = new FanRouter();
      this.navRegion.show(LoudrConfig.nav);
      LoudrConfig.nav.collection.show_logged_in_nav();
      return Backbone.history.start({
        pushState: true,
        root: "/app/"
      });
    });
    return Loudr;
  });

}).call(this);
