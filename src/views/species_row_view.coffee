window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.SpeciesRowView extends Backbone.View
  tagName: 'li'
  template: JST['species_row']

  initialize: (options) ->
    @model = options.model
    @listenTo(@model, 'change', @render)
    @listenTo(@model, 'change', @highlight)
    @render()

  render: =>
    @$el.html(@template(model: @model))

  highlight: ->
    @$el.fadeTo('slow', 0.5).fadeTo('slow', 1)

  onClose: ->
    @stopListening(@model, 'change', @render)
    @stopListening(@model, 'change', @highlight)
