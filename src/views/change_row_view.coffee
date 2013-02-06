window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.ChangeRowView extends Backbone.View
  tagName: 'li'
  template: JST['changes_row']

  events:
    "click button": "applyChange"

  initialize: (options) ->
    @model = options.model
    @render()

  render: =>
    @$el.html(@template(model: @model))

  applyChange: ->
    alert "if this worked, you would have applied change #{@model.get('id')}"

  onClose: ->
