(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["marionette"], function(Marionette) {
    var LoudrDashboard, LoudrProjectCollection, LoudrProjectCollectionView, LoudrProjectItem, LoudrProjectModel, _ref, _ref1, _ref2, _ref3, _ref4;

    LoudrProjectModel = (function(_super) {
      __extends(LoudrProjectModel, _super);

      function LoudrProjectModel() {
        _ref = LoudrProjectModel.__super__.constructor.apply(this, arguments);
        return _ref;
      }

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

      return LoudrProjectCollection;

    })(Backbone.Collection);
    LoudrProjectItem = (function(_super) {
      __extends(LoudrProjectItem, _super);

      function LoudrProjectItem() {
        _ref2 = LoudrProjectItem.__super__.constructor.apply(this, arguments);
        return _ref2;
      }

      LoudrProjectItem.prototype.tagName = 'li';

      LoudrProjectItem.prototype.template = "#project_list_template";

      return LoudrProjectItem;

    })(Marionette.ItemView);
    LoudrProjectCollectionView = (function(_super) {
      __extends(LoudrProjectCollectionView, _super);

      function LoudrProjectCollectionView() {
        _ref3 = LoudrProjectCollectionView.__super__.constructor.apply(this, arguments);
        return _ref3;
      }

      LoudrProjectCollectionView.prototype.tagName = 'ul';

      LoudrProjectCollectionView.prototype.itemView = LoudrProjectItem;

      return LoudrProjectCollectionView;

    })(Marionette.CollectionView);
    LoudrDashboard = (function(_super) {
      __extends(LoudrDashboard, _super);

      function LoudrDashboard() {
        _ref4 = LoudrDashboard.__super__.constructor.apply(this, arguments);
        return _ref4;
      }

      LoudrDashboard.prototype.template = "#dashboard_template";

      LoudrDashboard.prototype.regions = {
        projectsRegion: '#project_list'
      };

      LoudrDashboard.prototype.initialize = function(options) {
        return this.app = options.app;
      };

      LoudrDashboard.prototype.events = {
        'submit form': 'new_project',
        'click a': 'open_project'
      };

      LoudrDashboard.prototype.open_project = function(e) {
        return e.preventDefault();
      };

      LoudrDashboard.prototype.new_project = function(e) {
        e.preventDefault();
        return this.collection.create({
          name: this.$('#project_name').val()
        });
      };

      return LoudrDashboard;

    })(Marionette.Layout);
    return {
      Collection: LoudrProjectCollection,
      CollectionView: LoudrProjectCollectionView,
      Layout: LoudrDashboard
    };
  });

}).call(this);
