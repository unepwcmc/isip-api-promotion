window.Backbone.Models || = {}

class window.Backbone.Models.Change extends Backbone.Model
  getSpecies: ->
    if @species?
      return @species
    else
      return @species = ISIP.speciesList.where({id: @get('taxon_concept_id')})[0]

