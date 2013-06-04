define ['marionette', 'loudr.site'], (Marionette, SiteRouter) ->
  Loudr = new Marionette.Application()

  # configuration, setting up regions, etc ...
  Loudr.addRegions
    headerRegion: 'header'
    mainRegion: '#main'
    footerRegion: 'footer'
  
  Loudr.on 'initialize:after', () ->
    Backbone.history.start()

  site_router = new SiteRouter()

  return Loudr