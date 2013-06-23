(function() {
  define(['marionette', 'loudr.site', 'loudr.auth', 'loudr.login'], function(Marionette, SiteRouter, LoudrAuth, LoudrLogin) {
    var Loudr, auth, site_router;

    Loudr = new Marionette.Application();
    auth = new LoudrAuth();
    SiteRouter = Marionette.AppRouter.extend({
      controller: {
        home: function() {
          if (!auth.is_authed()) {
            return site_router.navigate('login', {
              trigger: true
            });
          }
        },
        login: function() {}
      },
      appRoutes: {
        "": "home",
        "login": "login"
      }
    });
    Loudr.addRegions({
      headerRegion: 'header',
      mainRegion: '#main'
    });
    Loudr.on('initialize:after', function() {
      return Backbone.history.start({
        pushState: true,
        root: "/app/"
      });
    });
    site_router = new SiteRouter();
    return Loudr;
  });

}).call(this);
