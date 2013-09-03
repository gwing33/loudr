(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["marionette"], function(Marionette) {
    var LoudrFanCollection, LoudrFanCollectionView, LoudrFanItem, LoudrFanModel, LoudrProject, _ref, _ref1, _ref2, _ref3, _ref4;

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

      LoudrFanCollection.prototype.model = LoudrFanModel;

      LoudrFanCollection.prototype.project_id = '';

      LoudrFanCollection.prototype.url = function() {
        return '/fan/' + this.project_id;
      };

      LoudrFanCollection.prototype.initialize = function(options) {
        return this.project_id = options.project_id;
      };

      LoudrFanCollection.prototype.parse = function(json) {
        return json.fans;
      };

      return LoudrFanCollection;

    })(Backbone.Collection);
    LoudrFanItem = (function(_super) {
      __extends(LoudrFanItem, _super);

      function LoudrFanItem() {
        _ref2 = LoudrFanItem.__super__.constructor.apply(this, arguments);
        return _ref2;
      }

      LoudrFanItem.prototype.tagName = 'li';

      LoudrFanItem.prototype.template = "#fan_list_template";

      return LoudrFanItem;

    })(Marionette.ItemView);
    LoudrFanCollectionView = (function(_super) {
      __extends(LoudrFanCollectionView, _super);

      function LoudrFanCollectionView() {
        _ref3 = LoudrFanCollectionView.__super__.constructor.apply(this, arguments);
        return _ref3;
      }

      LoudrFanCollectionView.prototype.tagName = 'ul';

      LoudrFanCollectionView.prototype.itemView = LoudrFanItem;

      return LoudrFanCollectionView;

    })(Marionette.CollectionView);
    LoudrProject = (function(_super) {
      __extends(LoudrProject, _super);

      function LoudrProject() {
        _ref4 = LoudrProject.__super__.constructor.apply(this, arguments);
        return _ref4;
      }

      LoudrProject.prototype.template = "#fan_list_template";

      LoudrProject.prototype.regions = {
        fansRegion: '#fan_list'
      };

      LoudrProject.prototype.initialize = function(options) {
        return this.app = options.app;
      };

      return LoudrProject;

    })(Marionette.Layout);
    return {
      FanCollection: LoudrFanCollection,
      FanCollectionView: LoudrFanCollectionView,
      Layout: LoudrProject
    };
  });

}).call(this);
