$ ->
  $('form#login').submit (e) ->
    e.preventDefault()

    el = $ @

    $.ajax
      url: el.attr 'action'
      type: el.attr 'method'
      dataType: 'json'
      data:
        email: el.find('[name="email"]').val()
        password: el.find('[name="password"]').val()
      success: (json) ->
        console.log json.reason unless json.success
      error: (blah, gah, doh) ->
        console.log blah, gah, doh

  $('form#create_user').submit (e) ->
    e.preventDefault()

    el = $ @

    $.ajax
      url: el.attr 'action'
      type: el.attr 'method'
      dataType: 'json'
      data:
        email: el.find('[name="email"]').val()
        password: el.find('[name="password"]').val()
      success: (json) ->
        console.log json.reason unless json.success
      error: (blah, gah, doh) ->
        console.log blah, gah, doh
  
  undefined