(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["backbone", "marionette"], function(Backbone, Marionette) {
    var DashboardLayout, _ref;
    DashboardLayout = (function(_super) {
      __extends(DashboardLayout, _super);

      function DashboardLayout() {
        _ref = DashboardLayout.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      DashboardLayout.prototype.template = "#dashboard_template";

      DashboardLayout.prototype.regions = {
        projectsRegion: '#project_list'
      };

      DashboardLayout.prototype.events = {
        'submit form': 'new_project',
        'click a': 'open_project'
      };

      DashboardLayout.prototype.open_project = function(e) {
        var url;
        e.preventDefault();
        url = $(e.currentTarget).attr('href');
        console.log(url);
        return Backbone.history.navigate(url, {
          trigger: true
        });
      };

      DashboardLayout.prototype.new_project = function(e) {
        e.preventDefault();
        return this.projectsRegion.currentView.collection.create({
          name: this.$('#project_name').val()
        }, {
          wait: true,
          success: function(json) {
            return this.$('#project_name').val('');
          },
          error: function(grr, blah, doh) {}
        });
      };

      return DashboardLayout;

    })(Marionette.Layout);
    return DashboardLayout;
  });

}).call(this);
