define ['marionette', 'routers/dashboardRouter', 'routers/projectRouter', 'routers/fanRouter', 'views/nav', 'models/auth'], (Marionette, DashboardRouter, ProjectRouter, FanRouter, LoudrNav, LoudrAuth) ->

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
    @nav = new LoudrNav.Layout
      collection: new LoudrNav.Collection()

  # After...
  Loudr.on 'initialize:after', () ->
    @routers = {}

    # Init Routers
    @routers.dash = new DashboardRouter
      app: @

    @routers.project = new ProjectRouter
      app: @

    @routers.fan = new FanRouter
      app: @

    @navRegion.show @nav

    @nav.collection.show_logged_in_nav()
    
    # Before app history start, should check for login?
    Backbone.history.start
      pushState: true
      root: "/app/"

  return Loudr