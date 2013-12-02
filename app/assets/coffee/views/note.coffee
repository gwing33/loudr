define [
  "backbone"
  "marionette"
  "loudr.config"
], (Backbone, Marionette, LoudrConfig) ->

  class NewNoteView extends Marionette.ItemView
    template: '#new_note_template'
    className: 'new-note-form'

  return NewNoteView