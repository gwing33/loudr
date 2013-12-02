(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["backbone"], function(Backbone) {
    var NoteModel, _ref;
    NoteModel = (function(_super) {
      __extends(NoteModel, _super);

      function NoteModel() {
        _ref = NoteModel.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      NoteModel.prototype.parse = function(json) {
        if (json.success) {
          return json.fan;
        }
        return json;
      };

      return NoteModel;

    })(Backbone.Model);
    return NoteModel;
  });

}).call(this);
