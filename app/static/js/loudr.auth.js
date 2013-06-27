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
      },
      login: function(email, password, cb) {
        var $this;

        $this = this;
        return $.ajax({
          url: '/login',
          data: {
            email: email,
            password: password
          },
          type: 'POST',
          dataType: 'json',
          success: function(json) {
            if (json.success) {
              console.log(this);
              $this.set({
                is_authed: true,
                auth_expire: $this.addHours(1)
              });
            }
            return cb(json.success);
          },
          error: function(err, blah, doh) {
            return console.log(err, blah, doh);
          }
        });
      }
    });
    return LoudrAuth;
  });

}).call(this);
