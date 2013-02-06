window.Backbone ||= {}
window.Backbone.Collections ||= {}

class Backbone.Collections.SpeciesCollection extends Backbone.Collection
  model: Backbone.Models.Species
  url: "data/species.json"

  parse: (data)->
    data[0].animalia.concat(data[0].animalia)
  
