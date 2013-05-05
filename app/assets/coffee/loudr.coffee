$ ->
  $('#login_form').submit (e) ->
    e.preventDefault()

    el = $ @

    $.ajax
      url: el.attr 'action'
      type: el.attr 'method'
      data:
        email: el.find('[name="email"]').val()
        password: el.find('[name="password"]').val()
      success: (json) ->
        console.log json
        return
      error: (blah, gah, doh) ->
        console.log blah, gah, doh
        return

    return false

  undefined