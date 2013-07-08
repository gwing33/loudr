define ["marionette"], (Marionette) ->

  class DashboardModel extends Backbone.Model
    init: (cb) ->
      # $this = @
      $.ajax
        url: '/dashboard',
        dataType: 'json',
        success: (json) ->
          cb json
        error: (err, blah, doh) ->
          console.log err, blah, doh
      
  return DashboardModel