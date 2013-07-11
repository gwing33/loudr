(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["marionette"], function(Marionette) {
    var LoudrDashboard, LoudrProjectCollection, LoudrProjectCollectionView, LoudrProjectItem, _ref, _ref1, _ref2, _ref3;

    LoudrProjectCollection = (function(_super) {
      var LoudrProjectModel, _ref1;

      __extends(LoudrProjectCollection, _super);

      function LoudrProjectCollection() {
        _ref = LoudrProjectCollection.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      LoudrProjectCollection.prototype.model = LoudrProjectModel = (function(_super1) {
        __extends(LoudrProjectModel, _super1);

        function LoudrProjectModel() {
          _ref1 = LoudrProjectModel.__super__.constructor.apply(this, arguments);
          return _ref1;
        }

        return LoudrProjectModel;

      })(Backbone.Model);

      return LoudrProjectCollection;

    })(Backbone.Collection);
    LoudrProjectItem = (function(_super) {
      __extends(LoudrProjectItem, _super);

      function LoudrProjectItem() {
        _ref1 = LoudrProjectItem.__super__.constructor.apply(this, arguments);
        return _ref1;
      }

      LoudrProjectItem.prototype.tagName = 'li';

      LoudrProjectItem.prototype.template = "#project_list_template";

      return LoudrProjectItem;

    })(Marionette.ItemView);
    LoudrProjectCollectionView = (function(_super) {
      __extends(LoudrProjectCollectionView, _super);

      function LoudrProjectCollectionView() {
        _ref2 = LoudrProjectCollectionView.__super__.constructor.apply(this, arguments);
        return _ref2;
      }

      LoudrProjectCollectionView.prototype.itemView = LoudrProjectItem;

      return LoudrProjectCollectionView;

    })(Marionette.CollectionView);
    LoudrDashboard = (function(_super) {
      __extends(LoudrDashboard, _super);

      function LoudrDashboard() {
        _ref3 = LoudrDashboard.__super__.constructor.apply(this, arguments);
        return _ref3;
      }

      LoudrDashboard.prototype.template = "#dashboard_template";

      LoudrDashboard.prototype.regions = {
        projectsRegion: '#project_list'
      };

      LoudrDashboard.prototype.initialize = function(options) {
        return this.app = options.app;
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
