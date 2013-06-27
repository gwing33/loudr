(function() {
  define(["marionette"], function(Marionette) {
    var LoudrNav;

    LoudrNav = Marionette.Layout.extend({
      initialize: function(options) {
        return this.app = options.app;
      },
      template: "#nav_template"
    });
    return LoudrNav;
  });

}).call(this);
