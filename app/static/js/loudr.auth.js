(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["marionette"], function(Marionette) {
    var LoudrAuth, _ref;

    LoudrAuth = (function(_super) {
      __extends(LoudrAuth, _super);

      function LoudrAuth() {
        _ref = LoudrAuth.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      LoudrAuth.prototype.login = function(email, password, cb) {
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
      };

      LoudrAuth.prototype.logout = function(cb) {
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
      };

      return LoudrAuth;

    })(Backbone.Model);
    return LoudrAuth;
  });

}).call(this);
