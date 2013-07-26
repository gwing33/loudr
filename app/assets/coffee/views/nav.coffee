define ["marionette", "backbone"], (Marionette, Backbone) ->

  class LoudrNavCollection extends Backbone.Collection
    model: class LoudrNavModel extends Backbone.Model

    show_logged_in_nav: () ->
      @add
        name: 'documentation'
        src: 'http://localhost:3003/'

  class LoudrNavItemView extends Marionette.ItemView
    tagName: 'li'
    template: "#nav_item_template"

  class LoudrNav extends Marionette.CollectionView
    tagName: 'ul'
    itemView: LoudrNavItemView

  return {
    Collection: LoudrNavCollection,
    Layout: LoudrNav
  }