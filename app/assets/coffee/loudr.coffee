define ['marionette', 'loudr.config', 'routers/dashboardRouter', 'routers/projectRouter', 'routers/fanRouter', 'views/nav', 'models/auth'], (Marionette, LoudrConfig, DashboardRouter, ProjectRouter, FanRouter, LoudrNav, LoudrAuth) ->

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
    LoudrConfig.auth = new LoudrAuth()

    # Init Navigation
    LoudrConfig.nav = new LoudrNav.Layout
      collection: new LoudrNav.Collection()

  # After...
  Loudr.on 'initialize:after', () ->
    # Init Routers
    LoudrConfig.routers.dash = new DashboardRouter()
    LoudrConfig.routers.project = new ProjectRouter()
    LoudrConfig.routers.fan = new FanRouter()

    @navRegion.show LoudrConfig.nav

    LoudrConfig.nav.collection.show_logged_in_nav()
    
    # Before app history start, should check for login?
    Backbone.history.start
      pushState: true
      root: "/app/"

  return Loudr