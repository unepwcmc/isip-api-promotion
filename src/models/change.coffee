window.Backbone.Models || = {}

class window.Backbone.Models.Change extends Backbone.Model
  initialize: ->
    @set(applied: false)

  # Get the species, memoize result to @species
  getSpecies: ->
    if @species?
      return @species
    else
      return @species = ISIP.speciesList.where({id: @get('taxon_concept_id')})[0]

  changeText: ->
    "#{@get('change_type_name')}: #{@getSpecies().get('species_name')} to appendix #{@get('species_listing_name')}"

  applyChange: ->
    @set(applied: true)
    @getSpecies().set(current_listing: @get('species_listing_name'))

