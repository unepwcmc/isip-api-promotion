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

  applyChange: ->
    @set(applied: true)

    unless (@get('previousListing')?)
      @set(previousListing: @getSpecies().get('current_listing'))

    @getSpecies().set(current_listing: @get('species_listing_name'))

  undoChange: ->
    @set(applied: false)

    @getSpecies().set(current_listing: @get('previousListing'))

  toggleChange: ->
    @set(applied: !@get('applied'))

    if @get('applied')
      unless (@get('previousListing')?)
        @set(previousListing: @getSpecies().get('current_listing'))

      @getSpecies().set(current_listing: @get('species_listing_name'))
    else
      @getSpecies().set(current_listing: @get('previousListing'))
