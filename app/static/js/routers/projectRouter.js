(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["backbone", "marionette", "loudr.config", "views/projectLayout", "models/fanModel", "views/fanList"], function(Backbone, Marionette, LoudrConfig, ProjectLayout, FanCollection, FanCollectionView) {
    var ProjectRouter, _ref;
    ProjectRouter = (function(_super) {
      __extends(ProjectRouter, _super);

      function ProjectRouter() {
        _ref = ProjectRouter.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      ProjectRouter.prototype.project_page_rendered = false;

      ProjectRouter.prototype.layout = {};

      ProjectRouter.prototype.fan_collection_view = {};

      ProjectRouter.prototype.controller = {
        project: function(project_id, key) {
          var fan_collection;
          if (key == null) {
            key = '';
          }
          this.project_page_rendered = true;
          this.layout = new ProjectLayout({
            project_id: project_id
          });
          fan_collection = new FanCollection([], {
            project_id: project_id,
            key: key
          });
          this.fan_collection_view = new FanCollectionView({
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
          LoudrConfig.app.mainRegion.show(this.layout);
          return this.layout.fansRegion.show(this.fan_collection_view);
        }
      };

      ProjectRouter.prototype.appRoutes = {
        "project/:project_id/": "project",
        "project/:project_id/key/:key": "project"
      };

      return ProjectRouter;

    })(Marionette.AppRouter);
    return ProjectRouter;
  });

}).call(this);
