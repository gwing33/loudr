define ["marionette"], (Marionette) ->
  class LoudrFanItem extends Marionette.ItemView
    tagName: 'li'
    template: "#fan_list_template"
    onBeforeRender: () ->
      console.log this

  class LoudrFanCollectionView extends Marionette.CollectionView
    tagName: 'ul'
    itemView: LoudrFanItem

  return LoudrFanCollectionView