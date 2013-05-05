(function() {
  $(function() {
    $('#login_form').submit(function(e) {
      var el;

      e.preventDefault();
      el = $(this);
      return $.ajax({
        url: el.attr('action'),
        type: el.attr('method'),
        dataType: 'json',
        data: {
          email: el.find('[name="email"]').val(),
          password: el.find('[name="password"]').val()
        },
        success: function(json) {
          if (!json.success) {
            return console.log(json.reason);
          }
        },
        error: function(blah, gah, doh) {
          return console.log(blah, gah, doh);
        }
      });
    });
    return void 0;
  });

}).call(this);
