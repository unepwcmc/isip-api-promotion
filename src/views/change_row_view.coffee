window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.ChangeRowView extends Backbone.View
  template: JST['changes_row']

  initialize: (options) ->
    @model = options.model
    @render()

  render: =>
    @$el.html(@template(model: @model))

  onClose: ->
