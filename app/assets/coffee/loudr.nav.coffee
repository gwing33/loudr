define ["marionette", "backbone"], (Marionette, Backbone) ->

  class LoudrNavCollection extends Backbone.Collection
    model: class LoudrNavModel extends Backbone.Model

  class LoudrNavItemView extends Marionette.ItemView
    tagName: 'li'
    template: "#nav_item_template"
    onBeforeRender: () ->
      console.log @

  class LoudrNav extends Marionette.CollectionView
    tagName: 'ul'
    itemView: LoudrNavItemView

  return {
    Collection: LoudrNavCollection,
    ItemView: LoudrNavItemView,
    Layout: LoudrNav
  }