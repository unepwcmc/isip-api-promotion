window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.SpeciesIndexView extends Backbone.Diorama.NestingView
  template: JST['species_index']

  initialize: (options) ->
    @speciesList = options.speciesList
    @listenTo(@speciesList, 'sync', @render)
    
    @render()

  render: =>
    @closeSubViews()
    @$el.html(@template(view: @, speciesModels: @speciesList.models))
    @renderSubViews()
    return @

  onClose: ->
    @closeSubViews()
    @stopListening(@speciesList, 'sync', @render)
