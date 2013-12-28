define [
  "backbone"
  "marionette"
  "loudr.config"
], (Backbone, Marionette, LoudrConfig) ->

  class LoudrProject extends Marionette.Layout
    project_id: false
    
    template: "#project_fans_template"
    className: 'fan-list-view'
    
    regions:
      fansRegion: '#fan_list'

    events:
      'click .new-note': 'new_note'

    initialize: (options) ->
      LoudrConfig.app.displayTitle "Project Fans"
      @project_id = options.project_id

    # Because I don't need to pass in a model really, I just need the project_id
    serializeData: () ->
      return { project_id: @project_id };

    new_note: (e) ->
      e.preventDefault()
      
      project_id = $(e.currentTarget).attr('data-project-id')
      LoudrConfig.app.newNote project_id

      # @note = new NewNoteView({ model: new NoteModel() })
      # LoudrConfig.app.noteRegion.show @note

  return LoudrProject