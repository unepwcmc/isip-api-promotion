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

    # Horrible hacks (kind of)
    # Because of the CSS animations for listing changes, re-rendering
    # the entire list when a change is applied will result in all the
    # animations re-running. Instead, we stop listening to model changes
    # after the first render to ensure that the list is rendered when
    # the json is loaded but not when any of the changes are applied.
    #
    # Suggestions for better solutions are welcome
    @listenTo(@changeList, 'change', =>
      @render()
      @stopListening(@changeList)
    )
    @speciesList = options.speciesList
    @listenTo(@speciesList, 'sync', @render)
    @listenTo(@speciesList, 'change', =>
      @render()
      @stopListening(@speciesList, 'change')
    )
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
