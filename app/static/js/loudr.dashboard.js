(function() {
  define(["marionette"], function(Marionette) {
    var LoudrDashboard;

    LoudrDashboard = Marionette.Layout.extend({
      initialize: function(options) {
        return this.app = options.app;
      },
      template: "#dashboard_template"
    });
    return LoudrDashboard;
  });

}).call(this);
