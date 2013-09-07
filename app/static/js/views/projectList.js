(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["backbone", "marionette"], function(Backbone, Marionette) {
    var ProjectCollectionView, ProjectItem, _ref, _ref1;

    ProjectItem = (function(_super) {
      __extends(ProjectItem, _super);

      function ProjectItem() {
        _ref = ProjectItem.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      ProjectItem.prototype.tagName = 'li';

      ProjectItem.prototype.template = "#project_list_template";

      return ProjectItem;

    })(Marionette.ItemView);
    ProjectCollectionView = (function(_super) {
      __extends(ProjectCollectionView, _super);

      function ProjectCollectionView() {
        _ref1 = ProjectCollectionView.__super__.constructor.apply(this, arguments);
        return _ref1;
      }

      ProjectCollectionView.prototype.tagName = 'ul';

      ProjectCollectionView.prototype.itemView = ProjectItem;

      return ProjectCollectionView;

    })(Marionette.CollectionView);
    return ProjectCollectionView;
  });

}).call(this);
