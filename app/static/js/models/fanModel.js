(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["backbone"], function(Backbone) {
    var FanCollection, FanModel, _ref, _ref1;
    FanModel = (function(_super) {
      __extends(FanModel, _super);

      function FanModel() {
        _ref = FanModel.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      FanModel.prototype.parse = function(json) {
        if (json.success) {
          return json.fan;
        }
        return json;
      };

      return FanModel;

    })(Backbone.Model);
    FanCollection = (function(_super) {
      __extends(FanCollection, _super);

      function FanCollection() {
        _ref1 = FanCollection.__super__.constructor.apply(this, arguments);
        return _ref1;
      }

      FanCollection.prototype.project_id = '';

      FanCollection.prototype.key = '';

      FanCollection.prototype.model = FanModel;

      FanCollection.prototype.url = function() {
        var qs;
        qs = this.key !== '' ? '?key=' + this.key : '';
        return '/project/' + this.project_id + '/fan/' + qs;
      };

      FanCollection.prototype.initialize = function(models, options) {
        this.project_id = options.project_id;
        return this.key = options.key;
      };

      FanCollection.prototype.parse = function(json) {
        return json.fans;
      };

      return FanCollection;

    })(Backbone.Collection);
    return FanCollection;
  });

}).call(this);
