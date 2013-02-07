window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.StatsView extends Backbone.View
  template: JST['stats']

  initialize: (options) ->
    @changeList = options.changeList
    @listenTo(@changeList, 'sync', @render)
    @listenTo(@changeList, 'change', @render)
    @render()

  render: =>
    appliedCount = @changeList.appliedChanges().length
    @$el.html(@template(
      outstandingCount: @changeList.outstandingChanges().length
      appliedCount: appliedCount
      hoursSaved: appliedCount*5
    ))

  onClose: ->
    @stopListening(@changeList, 'sync', @render)
