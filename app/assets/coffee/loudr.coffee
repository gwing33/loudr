define [
  'backbone'
  'marionette'
  'loudr.config'
  'routers/dashboardRouter'
  'routers/projectRouter'
  'routers/fanRouter'
  'views/nav'
  'models/auth'
  "models/noteModel"
  "views/note"
], (Backbone, Marionette, LoudrConfig, DashboardRouter, ProjectRouter, FanRouter, LoudrNav, LoudrAuth, NoteModel, NewNoteView) ->

  Loudr = new Marionette.Application()

  # configuration, setting up regions, etc ...
  Loudr.addRegions
    navRegion: '#main_nav'
    mainRegion: '#main'
    noteRegion: '#new_note'
    # footerRegion: 'footer'
  
  Loudr.setLocal = (name, obj) ->
    if Modernizr.localstorage
      localStorage.setItem name, JSON.stringify(obj)

  Loudr.getLocal = (name) ->
    if Modernizr.localstorage
      return JSON.parse localStorage.getItem name
    else
      return false

  Loudr.displayTitle = (text) ->
    $('#page_header div').html text

  Loudr.newNote = (project_id, to, message)->
    unless @note?
      @note = new NewNoteView({ model: new NoteModel() })

    if @noteRegion.currentView == @note
      @setLocal 'newNote', { note_showing: false }
      @noteRegion.close()
    else
      @setLocal 'newNote', { note_showing: true }
      @noteRegion.show @note

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

    # If the note is open then restore the state of what it was.
    new_note = @getLocal 'newNote'
    if new_note && new_note.note_showing
      @newNote()
    
    # Before app history start, should check for login?
    Backbone.history.start
      pushState: true
      root: "/app/"

  return Loudr