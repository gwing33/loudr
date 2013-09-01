(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["marionette", "views/dashboard", "views/login", "views/register"], function(Marionette, DashboardView, LoudrLogin, LoudrRegister) {
    var LoudrRouter, _ref;

    LoudrRouter = (function(_super) {
      __extends(LoudrRouter, _super);

      function LoudrRouter() {
        _ref = LoudrRouter.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      LoudrRouter.prototype.controller = {
        home: function() {
          var $this, dash, dash_collection, dash_collection_view;

          $this = this;
          dash = new DashboardView.Layout({
            app: $this.app
          });
          dash_collection = new DashboardView.Collection;
          dash_collection_view = new DashboardView.CollectionView({
            collection: dash_collection
          });
          dash_collection.fetch({
            error: function(err, blah, doh) {
              if (doh.xhr.status === 401) {
                return $this.app.router.navigate('login', {
                  trigger: true
                });
              }
            }
          });
          $this.app.mainRegion.show(dash);
          return dash.projectsRegion.show(dash_collection_view);
        },
        project: function(project_id) {
          return console.log(project_id);
        },
        register: function() {
          var login;

          login = new LoudrRegister({
            app: this.app
          });
          return this.app.mainRegion.show(login);
        },
        login: function() {
          var login;

          login = new LoudrLogin({
            app: this.app
          });
          this.app.mainRegion.show(login);
          return this.app.nav.collection.show_logged_out_nav();
        },
        logout: function() {
          var $this;

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
        "project/:project_id": "project",
        "register": "register",
        "login": "login",
        "logout": "logout"
      };

      return LoudrRouter;

    })(Marionette.AppRouter);
    return LoudrRouter;
  });

}).call(this);
