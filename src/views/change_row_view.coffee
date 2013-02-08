window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.ChangeRowView extends Backbone.View
  tagName: 'li'
  template: JST['changes_row']

  events:
    "click button": "applyChange"

  initialize: (options) ->
    @model = options.model
    @listenTo(@model, 'change', @render)
    @render()

  render: =>
    species = @model.getSpecies()
    @$el.html(@template(change: @model, species: species))

  applyChange: ->
    @model.applyChange()

  onClose: ->
