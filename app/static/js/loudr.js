(function() {
  $(function() {
    $('#login_form').submit(function(e) {
      var el;

      e.preventDefault();
      el = $(this);
      $.ajax({
        url: el.attr('action'),
        type: el.attr('method'),
        data: {
          email: el.find('[name="email"]').val(),
          password: el.find('[name="password"]').val()
        },
        success: function(json) {
          console.log(json);
        },
        error: function(blah, gah, doh) {
          console.log(blah, gah, doh);
        }
      });
      return false;
    });
    return void 0;
  });

}).call(this);
