define ["marionette"], (Marionette) ->

  class DashboardModel extends Backbone.Model
    init: (cb) ->
      # $this = @
      $.ajax
        url: '/dashboard',
        dataType: 'json',
        success: (json) ->
          cb null, json
        error: (err, blah, doh) ->
          cb doh
    
  return DashboardModel