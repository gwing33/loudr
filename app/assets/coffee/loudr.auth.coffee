define ["marionette"], (Marionette) ->

  LoudrAuth = Backbone.Model.extend
    initialize: () ->
      @.set
        is_authed: false
        auth_expire: false
    
    is_authed: () ->
      d = new Date()
      if d > @.attributes.auth_expire
        return false
      else
        return @.attributes.is_authed
    
    addHours: (h) ->
      d = new Date()
      return d.setHours d.getHours()+h
      
      # _id: @._id
      # email: @.email
      # name:
      #   first: @name.first
      #   last: @name.last
      #   full: @.name.full
      # loginAttempts: @.loginAttempts
      # locked: @.locked
    login: (email, password) ->
      $.ajax
        url: '/login',
        data:
          email: email
          password: password
        type: 'POST',
        dataType: 'json',
        success: (json) ->
          console.log json
        error: (err, blah, doh) ->
          console.log err, blah, doh

      return false

  return LoudrAuth