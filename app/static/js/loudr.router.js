(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["marionette", "loudr.dashboard", "loudr.login"], function(Marionette, LoudrDashboard, LoudrLogin) {
    var LoudrRouter, _ref;

    LoudrRouter = (function(_super) {
      __extends(LoudrRouter, _super);

      function LoudrRouter() {
        _ref = LoudrRouter.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      LoudrRouter.prototype.controller = {
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
      };

      LoudrRouter.prototype.initialize = function(options) {
        return this.controller.app = options.app;
      };

      LoudrRouter.prototype.appRoutes = {
        "": "home",
        "login": "login"
      };

      return LoudrRouter;

    })(Marionette.AppRouter);
    return LoudrRouter;
  });

}).call(this);
