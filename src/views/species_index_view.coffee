window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.SpeciesIndexView extends Backbone.View
  template: JST['species_index']

  initialize: (options) ->
    @speciesList = new Backbone.Collections.SpeciesCollection()
    @listenTo(@speciesList, 'sync', @render)
    @speciesList.fetch()
    
    @render()

  render: =>
    @closeSubViews()
    @$el.html(@template(view: @, speciesModels: @speciesList.models))
    @renderSubViews()
    return @

  addSubView: (subView) ->
    @subViews ||= []
    @subViews.push(subView)
    
    return "<#{subView.tagName} data-sub-view-cid=\"#{subView.cid}\"></#{subView.tagName}"
  
  renderSubViews: ->
    if @subViews?
      for subView in @subViews
        subView.setElement(@$el.find("[data-sub-view-cid=\"#{subView.cid}\"]"))
        subView.render()

  closeSubViews: ->
    if @subViews?
      for subView in @subViews
        subView.onClose()
        subView.close()

  onClose: ->
    @closeSubViews()
    @stopListening(@speciesList, 'sync', @render)
