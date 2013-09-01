define ['marionette', 'router', 'views/nav', 'models/auth', 'views/login'], (Marionette, LoudrRouter, LoudrNav, LoudrAuth, LoudrLogin) ->

  Loudr = new Marionette.Application()

  # configuration, setting up regions, etc ...
  Loudr.addRegions
    navRegion: '#main_nav'
    mainRegion: '#main'
    # footerRegion: 'footer'
  
  Loudr.displayTitle = (text) ->
    $('#page_header div').html text

  # On Init
  Loudr.addInitializer () ->
    # New Auth Lib
    @auth = new LoudrAuth()

    # Init Navigation
    @nav_collection = new LoudrNav.Collection()
    @nav = new LoudrNav.Layout
      collection: @nav_collection

  # After...
  Loudr.on 'initialize:after', () ->
    # Load in Router
    @router = new LoudrRouter
      app: @

    @navRegion.show @nav

    @nav_collection.show_logged_in_nav()
    
    # Before app history start, should check for login?
    Backbone.history.start
      pushState: true
      root: "/app/"

  return Loudr