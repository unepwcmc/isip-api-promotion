window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.ChangesIndexView extends Backbone.Diorama.NestingView
  template: JST['changes_index']

  initialize: (options) ->
    @changeList = options.changeList
    @listenTo(@changeList, 'sync', @render)
    @render()

  render: =>
    @closeSubViews()
    @$el.html(@template(view: @, changeModels: @changeList.models))
    @renderSubViews()
    
    return @

  onClose: ->
    @stopListening(@changeList, 'sync', @render)
    @closeSubViews()
