(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["backbone"], function(Backbone) {
    var ProjectCollection, ProjectModel, _ref, _ref1;
    ProjectModel = (function(_super) {
      __extends(ProjectModel, _super);

      function ProjectModel() {
        _ref = ProjectModel.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      ProjectModel.prototype.parse = function(json) {
        if (json.success) {
          return json.project;
        }
        return json;
      };

      return ProjectModel;

    })(Backbone.Model);
    ProjectCollection = (function(_super) {
      __extends(ProjectCollection, _super);

      function ProjectCollection() {
        _ref1 = ProjectCollection.__super__.constructor.apply(this, arguments);
        return _ref1;
      }

      ProjectCollection.prototype.model = ProjectModel;

      ProjectCollection.prototype.url = '/project';

      ProjectCollection.prototype.parse = function(json) {
        return json.projects;
      };

      return ProjectCollection;

    })(Backbone.Collection);
    return ProjectCollection;
  });

}).call(this);
