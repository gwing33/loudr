(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["backbone", "marionette", "loudr.config", "models/fanModel"], function(Backbone, Marionette, LoudrConfig, FanCollection) {
    var FanRouter, _ref;

    FanRouter = (function(_super) {
      __extends(FanRouter, _super);

      function FanRouter() {
        _ref = FanRouter.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      FanRouter.prototype.controller = {
        fan: function(project_id) {
          return console.log(project_id);
        },
        get_fan: function(project_id, id) {
          return console.log(project_id, id);
        }
      };

      FanRouter.prototype.appRoutes = {
        "project/:project_id/fan": "fan",
        "project/:project_id/fan/:id": "fan"
      };

      return FanRouter;

    })(Marionette.AppRouter);
    return FanRouter;
  });

}).call(this);
