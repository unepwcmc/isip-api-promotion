window.Backbone ||= {}
window.Backbone.Collections ||= {}

class Backbone.Collections.SpeciesCollection extends Backbone.Collection
  model: Backbone.Models.Species
  url: "data/species.json"
