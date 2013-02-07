window.Backbone ||= {}
window.Backbone.Collections ||= {}

class Backbone.Collections.ChangeCollection extends Backbone.Collection
  model: Backbone.Models.Change

  url: "data/changes.json"

  outstandingChanges: ->
    @where({applied: false})

  appliedChanges: ->
    @where({applied: true})
