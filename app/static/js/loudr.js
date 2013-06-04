(function() {
  define(['marionette', 'loudr.site'], function(Marionette, SiteRouter) {
    var Loudr, site_router;

    Loudr = new Marionette.Application();
    Loudr.addRegions({
      headerRegion: 'header',
      mainRegion: '#main',
      footerRegion: 'footer'
    });
    Loudr.on('initialize:after', function() {
      return Backbone.history.start();
    });
    site_router = new SiteRouter();
    return Loudr;
  });

}).call(this);
