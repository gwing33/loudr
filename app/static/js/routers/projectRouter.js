(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["backbone", "marionette", "views/projectLayout", "models/fanModel", "views/fanList"], function(Backbone, Marionette, ProjectLayout, FanCollection, FanCollectionView) {
    var ProjectRouter, _ref;

    ProjectRouter = (function(_super) {
      __extends(ProjectRouter, _super);

      function ProjectRouter() {
        _ref = ProjectRouter.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      ProjectRouter.prototype.controller = {
        project: function(project_id) {
          var $this, fan_collection, fan_collection_view, layout;

          $this = this;
          layout = new ProjectLayout({
            app: $this.app
          });
          fan_collection = new FanCollection([], {
            project_id: project_id
          });
          fan_collection_view = new FanCollectionView({
            collection: fan_collection
          });
          fan_collection.fetch({
            error: function(obj, err, doh) {
              if (doh.xhr.status === 401) {
                return Backbone.history.navigate('login', {
                  trigger: true
                });
              }
            }
          });
          $this.app.mainRegion.show(layout);
          return layout.fansRegion.show(fan_collection_view);
        }
      };

      ProjectRouter.prototype.initialize = function(options) {
        return this.controller.app = options.app;
      };

      ProjectRouter.prototype.appRoutes = {
        "project/:project_id": "project"
      };

      return ProjectRouter;

    })(Marionette.AppRouter);
    return ProjectRouter;
  });

}).call(this);
