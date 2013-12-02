define ["backbone"], (Backbone) ->
  
  class NoteModel extends Backbone.Model
    parse: (json) ->
      if json.success
        return json.fan
      
      return json

  return NoteModel