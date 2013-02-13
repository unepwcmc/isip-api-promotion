window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.ChangesIndexView extends Backbone.Diorama.NestingView
  template: JST['changes_index']

  events:
    "click #toggle-all": "toggleAll"

  initialize: (options) ->
    @changeList = options.changeList
    @listenTo(@changeList, 'sync', @render)
    @speciesList = options.speciesList
    @listenTo(@speciesList, 'sync', @render)
    @listenTo(@speciesList, 'change', @render)
    @render()

  render: =>
    @closeSubViews()
    @$el.html(@template(view: @, changeModels: @changeList.models, speciesCount: @speciesList.length))
    @renderSubViews()

    return @

  toggleAll: (e) ->
    @changeList.toggleAll()

  onClose: ->
    @stopListening(@changeList, 'sync', @render)
    @stopListening(@speciesList)
    @closeSubViews()
