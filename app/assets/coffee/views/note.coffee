define [
  "backbone",
  "marionette",
  "loudr.config"
], (Backbone, Marionette, LoudrConfig) ->

  class NoteView extends Marionette.AppRouter

  return NoteView