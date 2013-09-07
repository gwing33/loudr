(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["marionette"], function(Marionette) {
    var LoudrFanCollection, LoudrFanModel, _ref, _ref1;

    LoudrFanModel = (function(_super) {
      __extends(LoudrFanModel, _super);

      function LoudrFanModel() {
        _ref = LoudrFanModel.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      LoudrFanModel.prototype.parse = function(json) {
        if (json.success) {
          return json.fan;
        }
        return json;
      };

      return LoudrFanModel;

    })(Backbone.Model);
    LoudrFanCollection = (function(_super) {
      __extends(LoudrFanCollection, _super);

      function LoudrFanCollection() {
        _ref1 = LoudrFanCollection.__super__.constructor.apply(this, arguments);
        return _ref1;
      }

      LoudrFanCollection.prototype.project_id = '';

      LoudrFanCollection.prototype.model = LoudrFanModel;

      LoudrFanCollection.prototype.url = function() {
        return '/fan/' + this.project_id;
      };

      LoudrFanCollection.prototype.initialize = function(models, options) {
        return this.project_id = options.project_id;
      };

      LoudrFanCollection.prototype.parse = function(json) {
        return json.fans;
      };

      return LoudrFanCollection;

    })(Backbone.Collection);
    return LoudrFanCollection;
  });

}).call(this);
