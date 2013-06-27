define ['marionette', 'loudr.router', 'loudr.nav', 'loudr.auth', 'loudr.login'], (Marionette, LoudrRouter, LoudrNav, LoudrAuth, LoudrLogin) ->

  Loudr = new Marionette.Application()

  # configuration, setting up regions, etc ...
  Loudr.addRegions
    headerRegion: 'header'
    mainRegion: '#main'
    # footerRegion: 'footer'
  
  Loudr.addInitializer () ->
    @auth = new LoudrAuth()
    @nav = new LoudrNav
      app: @

  Loudr.on 'initialize:after', () ->
    @router = new LoudrRouter
      app: @

    @headerRegion.show @nav

    # Before app history start, should check for login?
    Backbone.history.start
      pushState: true
      root: "/app/"

  return Loudr