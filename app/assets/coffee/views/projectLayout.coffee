define ["backbone", "marionette"], (Backbone, Marionette) ->

  class LoudrProject extends Marionette.Layout
    project_id: false
    
    template: "#project_fans_template"
    
    regions:
      fansRegion: '#fan_list'

    events:
      'click .new-note': 'new_note'

    initialize: (options) ->
      @project_id = options.project_id

    # Because I don't need to pass in a model really, I just need the project_id
    serializeData: () ->
      return { project_id: @project_id };

    new_note: (e) ->
      e.preventDefault()
      
      href = $(e.currentTarget).attr('href').replace('/app','')
      
      Backbone.history.navigate href, {trigger: true}
      # console.log 'New Note'

  return LoudrProject