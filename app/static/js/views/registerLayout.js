(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["backbone", "marionette", 'loudr.config'], function(Backbone, Marionette, LoudrConfig) {
    var LoudrRegister, _ref;

    LoudrRegister = (function(_super) {
      __extends(LoudrRegister, _super);

      function LoudrRegister() {
        _ref = LoudrRegister.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      LoudrRegister.prototype.events = {
        "submit form": "attempt_register"
      };

      LoudrRegister.prototype.template = "#register_template";

      LoudrRegister.prototype.attempt_register = function(e) {
        var email, full_name, password;

        e.preventDefault();
        full_name = this.$('input[name="full_name"]').val();
        email = this.$('input[name="email"]').val();
        password = this.$('input[name="password"]').val();
        return LoudrConfig.app.auth.register(full_name, email, password, function(success) {
          if (success) {
            Backbone.history.navigate('/', {
              trigger: true
            });
          }
        });
      };

      return LoudrRegister;

    })(Marionette.Layout);
    return LoudrRegister;
  });

}).call(this);
