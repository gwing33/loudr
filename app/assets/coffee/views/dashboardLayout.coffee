define ["backbone", "marionette"], (Backbone, Marionette) ->

  # I left it as 'LoudrDashboard' because it's the landing page.
  # There could be more things than just a list of projects.
  class DashboardLayout extends Marionette.Layout
    template: "#dashboard_template"
    regions:
      projectsRegion: '#project_list'

    events:
      'submit form': 'new_project',
      'click a': 'open_project'

    # initialize: () ->
    #   Loudr.displayTitle "wtf"

    open_project: (e) ->
      e.preventDefault()
      url = $(e.currentTarget).attr('href')
      console.log url

      Backbone.history.navigate url, {trigger: true}

    new_project: (e) ->
      e.preventDefault()

      @projectsRegion.currentView.collection.create { name: @$('#project_name').val() }, 
        wait: true
        success: (json) ->
          # Reset Value
          @$('#project_name').val ''
        error: (grr, blah, doh) ->
          # TODO
          # console.log grr, blah, doh

  return DashboardLayout