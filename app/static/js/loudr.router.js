(function() {
  define(["marionette", "loudr.login"], function(Marionette, LoudrLogin) {
    var LoudrRouter;

    LoudrRouter = Marionette.AppRouter.extend({
      controller: {
        home: function() {
          if (!this.app.auth.is_authed()) {
            return this.app.router.navigate('login', {
              trigger: true
            });
          }
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
