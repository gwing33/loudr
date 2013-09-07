define ['marionette', 'routers/dashboardRouter', 'routers/projectRouter', 'views/nav', 'models/auth'], (Marionette, DashboardRouter, ProjectRouter, LoudrNav, LoudrAuth) ->

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
    nav_collection = new LoudrNav.Collection()
    @nav = new LoudrNav.Layout
      collection: nav_collection

  # After...
  Loudr.on 'initialize:after', () ->
    @router = {}

    # Init Routers
    @router.dash = new DashboardRouter
      app: @

    @router.project = new ProjectRouter
      app: @

    @navRegion.show @nav

    @nav.collection.show_logged_in_nav()
    
    # Before app history start, should check for login?
    Backbone.history.start
      pushState: true
      root: "/app/"

  return Loudr