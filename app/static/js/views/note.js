(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["backbone", "marionette", "loudr.config"], function(Backbone, Marionette, LoudrConfig) {
    var NewNoteView, _ref;
    NewNoteView = (function(_super) {
      __extends(NewNoteView, _super);

      function NewNoteView() {
        _ref = NewNoteView.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      NewNoteView.prototype.template = '#new_note_template';

      NewNoteView.prototype.className = 'new-note-form';

      return NewNoteView;

    })(Marionette.ItemView);
    return NewNoteView;
  });

}).call(this);
