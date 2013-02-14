window.Backbone ||= {}
window.Backbone.Collections ||= {}

class Backbone.Collections.ChangeCollection extends Backbone.Collection
  model: Backbone.Models.Change

  url: "data/changes.json"

  applyAll: ->
    @each((model)->
      model.applyChange()
    )

  undoAll: ->
    @each((model)->
      model.undoChange()
    )

  toggleAll: ->
    @each((model)->
      model.toggleChange()
    )

  outstandingChanges: ->
    @where({applied: false})

  appliedChanges: ->
    @where({applied: true})
