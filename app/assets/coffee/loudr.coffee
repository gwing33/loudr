define ['marionette', 'router', 'views/nav', 'models/auth', 'views/login'], (Marionette, LoudrRouter, LoudrNav, LoudrAuth, LoudrLogin) ->

  Loudr = new Marionette.Application()

  # configuration, setting up regions, etc ...
  Loudr.addRegions
    navRegion: 'header nav'
    mainRegion: '#main'
    # footerRegion: 'footer'
  
  Loudr.addInitializer () ->
    @auth = new LoudrAuth()

    # Build Nav items
    @nav_collection = new LoudrNav.Collection()
    @nav = new LoudrNav.Layout
      collection: @nav_collection

  Loudr.on 'initialize:after', () ->
    @router = new LoudrRouter
      app: @

    @navRegion.show @nav

    # Before app history start, should check for login?
    Backbone.history.start
      pushState: true
      root: "/app/"

  return Loudr