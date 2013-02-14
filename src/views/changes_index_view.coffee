window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.ChangesIndexView extends Backbone.Diorama.NestingView
  template: JST['changes_index']

  events:
    "click #apply-all" : "applyAll"
    "click #undo-all"  : "undoAll"

  initialize: (options) ->
    @changeList = options.changeList
    @listenTo(@changeList, 'sync', @render)
    @speciesList = options.speciesList
    @listenTo(@speciesList, 'sync', @render)
    @listenTo(@speciesList, 'change', @render)
    @render()

  render: =>
    @closeSubViews()
    @$el.html(@template(view: @, changeList: @changeList, speciesCount: @speciesList.length))
    @renderSubViews()

    return @

  undoAll: (e) ->
    @changeList.undoAll()
    @render()

  applyAll: (e) ->
    @changeList.applyAll()
    @render()

  onClose: ->
    @stopListening(@changeList, 'sync', @render)
    @stopListening(@speciesList)
    @closeSubViews()
