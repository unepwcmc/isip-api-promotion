window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.SpeciesIndexView extends Backbone.View
  template: JST['species_index']

  initialize: (options) ->
    @speciesList = new Backbone.Collections.SpeciesCollection()
    @listenTo(@speciesList, 'sync', @render)
    @speciesList.fetch()
    
    @render()

  render: =>
    console.log "rendering with:"
    console.log @speciesList.models
    @$el.html(@template(speciesModels: @speciesList.models))

  onClose: ->
