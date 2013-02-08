window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.ChangesIndexView extends Backbone.Diorama.NestingView
  template: JST['changes_index']

  events:
    "click #apply-all": "applyAll"

  initialize: (options) ->
    @changeList = options.changeList
    @listenTo(@changeList, 'sync', @render)
    @speciesList = options.speciesList
    @listenTo(@speciesList, 'sync', @render)
    @render()

  render: =>
    @closeSubViews()
    @$el.html(@template(view: @, changeModels: @changeList.models))
    @renderSubViews()
    
    return @
  
  applyAll: ->
    @changeList.applyAll()

  onClose: ->
    @stopListening(@changeList, 'sync', @render)
    @stopListening(@speciesList, 'sync', @render)
    @closeSubViews()
