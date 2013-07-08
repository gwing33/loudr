define ['marionette', 'router', 'views/nav', 'models/auth', 'views/login'], (Marionette, LoudrRouter, LoudrNav, LoudrAuth, LoudrLogin) ->

  Loudr = new Marionette.Application()

  # configuration, setting up regions, etc ...
  Loudr.addRegions
    navRegion: 'header nav'
    mainRegion: '#main'
    # footerRegion: 'footer'
  
  Loudr.addInitializer () ->
    @auth = new LoudrAuth()

    @nav_collection = new LoudrNav.Collection()
    # @nav_collection.add
    #   name: 'messages'
    #   src: '#'

    @nav = new LoudrNav.Layout
      collection: @nav_collection

  Loudr.on 'initialize:after', () ->
    @router = new LoudrRouter
      app: @

    @navRegion.show @nav

    # Call Dashboard

    # Before app history start, should check for login?
    Backbone.history.start
      pushState: true
      root: "/app/"

  return Loudr