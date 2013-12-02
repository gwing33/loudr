(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["backbone", "marionette", "loudr.config"], function(Backbone, Marionette, LoudrConfig) {
    var LoudrProject, _ref;
    LoudrProject = (function(_super) {
      __extends(LoudrProject, _super);

      function LoudrProject() {
        _ref = LoudrProject.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      LoudrProject.prototype.project_id = false;

      LoudrProject.prototype.template = "#project_fans_template";

      LoudrProject.prototype.className = 'fan-list-view';

      LoudrProject.prototype.regions = {
        fansRegion: '#fan_list',
        noteRegion: '#new_note'
      };

      LoudrProject.prototype.events = {
        'click .new-note': 'new_note'
      };

      LoudrProject.prototype.initialize = function(options) {
        LoudrConfig.app.displayTitle("Project Fans");
        return this.project_id = options.project_id;
      };

      LoudrProject.prototype.serializeData = function() {
        return {
          project_id: this.project_id
        };
      };

      LoudrProject.prototype.new_note = function(e) {
        var href;
        e.preventDefault();
        href = $(e.currentTarget).attr('href').replace('/app', '');
        return Backbone.history.navigate(href, {
          trigger: true
        });
      };

      return LoudrProject;

    })(Marionette.Layout);
    return LoudrProject;
  });

}).call(this);
