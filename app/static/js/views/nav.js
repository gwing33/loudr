(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["marionette", "backbone"], function(Marionette, Backbone) {
    var LoudrNav, LoudrNavCollection, LoudrNavItemView, _ref, _ref1, _ref2;

    LoudrNavCollection = (function(_super) {
      var LoudrNavModel, _ref1;

      __extends(LoudrNavCollection, _super);

      function LoudrNavCollection() {
        _ref = LoudrNavCollection.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      LoudrNavCollection.prototype.model = LoudrNavModel = (function(_super1) {
        __extends(LoudrNavModel, _super1);

        function LoudrNavModel() {
          _ref1 = LoudrNavModel.__super__.constructor.apply(this, arguments);
          return _ref1;
        }

        return LoudrNavModel;

      })(Backbone.Model);

      LoudrNavCollection.prototype.show_logged_in_nav = function() {
        return this.add({
          name: 'documentation',
          src: 'http://localhost:3003/'
        });
      };

      return LoudrNavCollection;

    })(Backbone.Collection);
    LoudrNavItemView = (function(_super) {
      __extends(LoudrNavItemView, _super);

      function LoudrNavItemView() {
        _ref1 = LoudrNavItemView.__super__.constructor.apply(this, arguments);
        return _ref1;
      }

      LoudrNavItemView.prototype.tagName = 'li';

      LoudrNavItemView.prototype.template = "#nav_item_template";

      return LoudrNavItemView;

    })(Marionette.ItemView);
    LoudrNav = (function(_super) {
      __extends(LoudrNav, _super);

      function LoudrNav() {
        _ref2 = LoudrNav.__super__.constructor.apply(this, arguments);
        return _ref2;
      }

      LoudrNav.prototype.tagName = 'ul';

      LoudrNav.prototype.itemView = LoudrNavItemView;

      return LoudrNav;

    })(Marionette.CollectionView);
    return {
      Collection: LoudrNavCollection,
      Layout: LoudrNav
    };
  });

}).call(this);
