(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["marionette"], function(Marionette) {
    var LoudrFanCollectionView, LoudrFanItem, _ref, _ref1;

    LoudrFanItem = (function(_super) {
      __extends(LoudrFanItem, _super);

      function LoudrFanItem() {
        _ref = LoudrFanItem.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      LoudrFanItem.prototype.tagName = 'li';

      LoudrFanItem.prototype.template = "#fan_list_template";

      return LoudrFanItem;

    })(Marionette.ItemView);
    LoudrFanCollectionView = (function(_super) {
      __extends(LoudrFanCollectionView, _super);

      function LoudrFanCollectionView() {
        _ref1 = LoudrFanCollectionView.__super__.constructor.apply(this, arguments);
        return _ref1;
      }

      LoudrFanCollectionView.prototype.tagName = 'ul';

      LoudrFanCollectionView.prototype.itemView = LoudrFanItem;

      return LoudrFanCollectionView;

    })(Marionette.CollectionView);
    return LoudrFanCollectionView;
  });

}).call(this);
