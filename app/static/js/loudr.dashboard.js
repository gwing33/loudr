(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["marionette"], function(Marionette) {
    var LoudrDashboard, _ref;

    LoudrDashboard = (function(_super) {
      __extends(LoudrDashboard, _super);

      function LoudrDashboard() {
        _ref = LoudrDashboard.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      LoudrDashboard.prototype.initialize = function(options) {
        return this.app = options.app;
      };

      LoudrDashboard.prototype.template = "#dashboard_template";

      return LoudrDashboard;

    })(Marionette.Layout);
    return LoudrDashboard;
  });

}).call(this);
