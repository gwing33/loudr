(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["marionette"], function(Marionette) {
    var LoudrProject, _ref;

    LoudrProject = (function(_super) {
      __extends(LoudrProject, _super);

      function LoudrProject() {
        _ref = LoudrProject.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      LoudrProject.prototype.template = "#project_fans_template";

      LoudrProject.prototype.regions = {
        fansRegion: '#fan_list'
      };

      LoudrProject.prototype.initialize = function(options) {
        return this.app = options.app;
      };

      return LoudrProject;

    })(Marionette.Layout);
    return LoudrProject;
  });

}).call(this);
