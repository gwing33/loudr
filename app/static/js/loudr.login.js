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
        var email, password;

        e.preventDefault();
        email = this.$('input[name="email"]').val();
        password = this.$('input[name="password"]').val();
        console.log(email, password);
        return this.app.auth.login(email, password);
      }
    });
    return LoudrLogin;
  });

}).call(this);
