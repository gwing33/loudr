(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["marionette", "models/dashboard", "views/dashboard", "views/login"], function(Marionette, DashboardModel, DashboardView, LoudrLogin) {
    var LoudrRouter, _ref;

    LoudrRouter = (function(_super) {
      __extends(LoudrRouter, _super);

      function LoudrRouter() {
        _ref = LoudrRouter.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      LoudrRouter.prototype.controller = {
        home: function() {
          var $this, dash_model;

          $this = this;
          dash_model = new DashboardModel();
          return dash_model.init(function(json) {
            var dash;

            if (!json.success) {
              return $this.app.router.navigate('login', {
                trigger: true
              });
            }
            dash = new DashboardView({
              app: $this.app
            });
            return $this.app.mainRegion.show(dash);
          });
        },
        login: function() {
          var login;

          login = new LoudrLogin({
            app: this.app
          });
          return this.app.mainRegion.show(login);
        },
        logout: function() {
          var $this;

          console.log('logging out');
          $this = this;
          return this.app.auth.logout(function() {
            return $this.app.router.navigate('login', {
              trigger: true
            });
          });
        }
      };

      LoudrRouter.prototype.initialize = function(options) {
        return this.controller.app = options.app;
      };

      LoudrRouter.prototype.appRoutes = {
        "": "home",
        "login": "login",
        "logout": "logout"
      };

      return LoudrRouter;

    })(Marionette.AppRouter);
    return LoudrRouter;
  });

}).call(this);
