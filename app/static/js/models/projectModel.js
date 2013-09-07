(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["backbone", "marionette"], function(Backbone, Marionette) {
    var LoudrProjectCollection, LoudrProjectModel, _ref, _ref1;

    LoudrProjectModel = (function(_super) {
      __extends(LoudrProjectModel, _super);

      function LoudrProjectModel() {
        _ref = LoudrProjectModel.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      LoudrProjectModel.prototype.parse = function(json) {
        if (json.success) {
          return json.project;
        }
        return json;
      };

      return LoudrProjectModel;

    })(Backbone.Model);
    LoudrProjectCollection = (function(_super) {
      __extends(LoudrProjectCollection, _super);

      function LoudrProjectCollection() {
        _ref1 = LoudrProjectCollection.__super__.constructor.apply(this, arguments);
        return _ref1;
      }

      LoudrProjectCollection.prototype.model = LoudrProjectModel;

      LoudrProjectCollection.prototype.url = '/project';

      LoudrProjectCollection.prototype.parse = function(json) {
        return json.projects;
      };

      return LoudrProjectCollection;

    })(Backbone.Collection);
    return LoudrProjectCollection;
  });

}).call(this);
