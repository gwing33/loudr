# Configure Require
require.config
  paths:
    backbone: '/js/vendor/backbone'
    underscore: '/js/vendor/underscore'
    jquery: '/js/vendor/jquery-1.9.1.min'
  shim:
    jquery:
      exports: 'jQuery'
    underscore:
      exports: '_'
    backbone:
      deps: ['jquery', 'underscore']
      exports: 'Backbone'

# Loudr will pull in needed applications
define ['jquery', 'backbone'], ($, Backbone) ->
  doc_router = {}
  nav = {}

  cached_pages = {}

  DocRouter = Backbone.Router.extend
    routes:
      'docs': 'getDefault'
      'docs/:page': 'getPage'

    getDefault: () ->
      this.getPage 'overview'
      
    getPage: (page) ->
      if cached_pages[page]?
        $('#main').html cached_pages[page]
        return
      
      $.ajax
        url: '/docs/partial/' + page
        success: (html) ->
          cached_pages[page] = html
          $('#main').html html
        error: () ->
          $('#main').html 'Problem loading API Document.'

  DocNav = Backbone.View.extend
    el: '#main_nav'

    events:
      'click a': 'goToPage'

    goToPage: (e) ->
      e.preventDefault()
      el = $(e.currentTarget)
      href = el.attr 'href'

      doc_router.navigate href, { trigger: true }

  # Start up App, Router and listen to the url
  $ () ->
    doc_router = new DocRouter()
    nav = new DocNav()
    
    unless Modernizr.history
      Backbone.history.start
        silent: true
    else
      Backbone.history.start
        pushState: true
        silent: true

  