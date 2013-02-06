window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.ChangesIndexView extends Backbone.Diorama.NestingView
  template: JST['changes_index']

  initialize: (options) ->
    @changeList = new Backbone.Collections.ChangeCollection()
    @listenTo(@changeList, 'sync', @render)
    @changeList.fetch()
    @render()

  render: =>
    @closeSubViews()
    @$el.html(@template(view: @, changeModels: @changeList.models))
    @renderSubViews()
    
    return @

  onClose: ->
    @closeSubViews()
