define ['marionette', 'loudr.router', 'loudr.auth', 'loudr.login'], (Marionette, LoudrRouter, LoudrAuth, LoudrLogin) ->
  Loudr = new Marionette.Application()

  # configuration, setting up regions, etc ...
  Loudr.addRegions
    headerRegion: 'header'
    mainRegion: '#main'
    # footerRegion: 'footer'
  
  Loudr.addInitializer () ->
    @auth = new LoudrAuth()

  Loudr.on 'initialize:after', () ->
    @router = new LoudrRouter
      app: @

    Backbone.history.start
      pushState: true
      root: "/app/"

  return Loudr