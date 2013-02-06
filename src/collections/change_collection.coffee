window.Backbone ||= {}
window.Backbone.Collections ||= {}

class Backbone.Collections.ChangeCollection extends Backbone.Collection
  model: Backbone.Models.Change

  url: "data/species.json"

  parse: (data)->
    data[0].animalia.concat(data[0].animalia)

