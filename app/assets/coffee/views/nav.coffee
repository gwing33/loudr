define ["marionette", "backbone"], (Marionette, Backbone) ->

  class LoudrNavCollection extends Backbone.Collection
    model: class LoudrNavModel extends Backbone.Model

    show_logged_in_nav: () ->
      @add
        icon: '<i class="icon-file-alt"></i>'
        name: 'API Docs'
        src: '/docs'
        class_name: 'api-docs-nav'

      @add
        icon: '<i class="icon-remove"></i>'
        name: 'Hide Menu'
        src: 'http://localhost:3003/'
        class_name: 'hide-responsive-nav'

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