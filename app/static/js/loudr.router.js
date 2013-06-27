(function() {
  define(["marionette", "loudr.dashboard", "loudr.login"], function(Marionette, LoudrDashboard, LoudrLogin) {
    var LoudrRouter;

    LoudrRouter = Marionette.AppRouter.extend({
      controller: {
        home: function() {
          var dash;

          dash = new LoudrDashboard({
            app: this.app
          });
          return this.app.mainRegion.show(dash);
        },
        login: function() {
          var login;

          login = new LoudrLogin({
            app: this.app
          });
          return this.app.mainRegion.show(login);
        }
      },
      initialize: function(options) {
        return this.controller.app = options.app;
      },
      appRoutes: {
        "": "home",
        "login": "login"
      }
    });
    return LoudrRouter;
  });

}).call(this);
