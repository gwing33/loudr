define ["marionette"], (Marionette) ->
  siteController =
    home: () ->
      console.log 'home'
    login: () ->
      console.log 'login'

  SiteRouter = Marionette.AppRouter.extend
    controller: siteController
    appRoutes:
      "": "home"
      "login": "login"

  return SiteRouter