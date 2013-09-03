define ["marionette"], (Marionette) ->
  class LoudrFanModel extends Backbone.Model
    parse: (json) ->
      if json.success
        return json.fan
      
      return json

  class LoudrFanCollection extends Backbone.Collection
    model: LoudrFanModel
    
    project_id: ''
    
    url: () ->
      return '/fan/' + @project_id

    initialize: (options) ->
      @project_id = options.project_id

    parse: (json) ->
      return json.fans

  class LoudrFanItem extends Marionette.ItemView
    tagName: 'li'
    template: "#fan_list_template"

  class LoudrFanCollectionView extends Marionette.CollectionView
    tagName: 'ul'
    itemView: LoudrFanItem

  class LoudrProject extends Marionette.Layout
    template: "#fan_list_template"
    regions:
      fansRegion: '#fan_list'

    initialize: (options) ->
      @app = options.app

  return {
    FanCollection: LoudrFanCollection
    FanCollectionView: LoudrFanCollectionView
    Layout: LoudrProject
  }