(function() {
  define(["marionette"], function(Marionette) {
    var LoudrAuth;

    LoudrAuth = Backbone.Model.extend({
      login: function(email, password, cb) {
        return $.ajax({
          url: '/login',
          data: {
            email: email,
            password: password
          },
          type: 'POST',
          dataType: 'json',
          success: function(json) {
            return cb(json.success);
          },
          error: function(err, blah, doh) {
            return console.log(err, blah, doh);
          }
        });
      },
      logout: function(cb) {
        return $.ajax({
          url: '/logout',
          type: 'GET',
          dataType: 'json',
          success: function(json) {
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
