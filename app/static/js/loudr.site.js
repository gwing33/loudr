(function() {
  define(["marionette"], function(Marionette) {
    var SiteRouter, siteController;

    siteController = {
      home: function() {
        return console.log('home');
      },
      login: function() {
        return console.log('login');
      }
    };
    SiteRouter = Marionette.AppRouter.extend({
      controller: siteController,
      appRoutes: {
        "": "home",
        "login": "login"
      }
    });
    return SiteRouter;
  });

}).call(this);
