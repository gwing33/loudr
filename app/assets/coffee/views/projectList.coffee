define ["marionette"], (Marionette) ->

  class ProjectItem extends Marionette.ItemView
    tagName: 'li'
    template: "#project_list_template"

  class ProjectCollectionView extends Marionette.CollectionView
    tagName: 'ul'
    itemView: ProjectItem

  return ProjectCollectionView