(function() {
  define(["marionette"], function(Marionette) {
    var LoudrAuth;

    LoudrAuth = Backbone.Model.extend({
      initialize: function() {
        return this.set({
          is_authed: false,
          auth_expire: false
        });
      },
      is_authed: function() {
        var d;

        d = new Date();
        if (d > this.attributes.auth_expire) {
          return false;
        } else {
          return this.attributes.is_authed;
        }
      },
      addHours: function(h) {
        var d;

        d = new Date();
        return d.setHours(d.getHours() + h);
      }
    });
    return LoudrAuth;
  });

}).call(this);
