define [
  "backbone"
  "marionette"
  "loudr.config"
], (Backbone, Marionette, LoudrConfig) ->

  class NewNoteView extends Marionette.ItemView
    template: '#new_note_template'
    className: 'new-note-form'

    events:
      'click .send': 'sendNote'
      'click .discard': 'closeNote'

    sendNote: (e) ->
      e.preventDefault()

      @.model.set
        'to': this.$('input').val()
        'message': this.$('textarea').val()

      # Save Model
      # Navigate to Sent Note Page?

    closeNote: (e) ->
      e.preventDefault()
      LoudrConfig.app.noteRegion.close()
      
  return NewNoteView