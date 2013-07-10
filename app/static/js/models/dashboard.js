(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["marionette"], function(Marionette) {
    var DashboardModel, _ref;

    DashboardModel = (function(_super) {
      __extends(DashboardModel, _super);

      function DashboardModel() {
        _ref = DashboardModel.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      DashboardModel.prototype.init = function(cb) {
        return $.ajax({
          url: '/dashboard',
          dataType: 'json',
          success: function(json) {
            return cb(null, json);
          },
          error: function(err, blah, doh) {
            return cb(doh);
          }
        });
      };

      return DashboardModel;

    })(Backbone.Model);
    return DashboardModel;
  });

}).call(this);
