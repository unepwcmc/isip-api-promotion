window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.SpeciesRowView extends Backbone.View
  template: JST['species_row']

  initialize: (options) ->
    @model = options.model
    @render()

  render: =>
    @$el.html(@template(model: @model))

  onClose: ->
