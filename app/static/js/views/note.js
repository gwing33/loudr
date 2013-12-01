(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["backbone", "marionette", "loudr.config"], function(Backbone, Marionette, LoudrConfig) {
    var NoteView, _ref;
    NoteView = (function(_super) {
      __extends(NoteView, _super);

      function NoteView() {
        _ref = NoteView.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      return NoteView;

    })(Marionette.AppRouter);
    return NoteView;
  });

}).call(this);
