(function() {
  define(["marionette"], function(Marionette) {
    var LoudrLogin;

    LoudrLogin = Marionette.Layout.extend({
      initialize: function(options) {
        return this.app = options.app;
      },
      events: {
        "submit form": "attempt_login"
      },
      template: "#login_template",
      attempt_login: function(e) {
        var $this, email, password;

        e.preventDefault();
        email = this.$('input[name="email"]').val();
        password = this.$('input[name="password"]').val();
        $this = this;
        return this.app.auth.login(email, password, function(success) {
          if (success) {
            $this.app.router.navigate('/', {
              trigger: true
            });
            return;
          }
          return console.log(success);
        });
      }
    });
    return LoudrLogin;
  });

}).call(this);
