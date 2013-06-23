define ['marionette', 'loudr.site', 'loudr.auth', 'loudr.login'], (Marionette, SiteRouter, LoudrAuth, LoudrLogin) ->
  Loudr = new Marionette.Application()
  auth = new LoudrAuth();


  SiteRouter = Marionette.AppRouter.extend
    controller:
      home: () ->
        site_router.navigate 'login', {trigger: true} unless auth.is_authed()
      login: () ->
        # Render Login page
    appRoutes:
      "": "home"
      "login": "login"

  # configuration, setting up regions, etc ...
  Loudr.addRegions
    headerRegion: 'header'
    mainRegion: '#main'
    # footerRegion: 'footer'
  
  Loudr.on 'initialize:after', () ->
    Backbone.history.start
      pushState: true
      root: "/app/"

  site_router = new SiteRouter()

  return Loudr