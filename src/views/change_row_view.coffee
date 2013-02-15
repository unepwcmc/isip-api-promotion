window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.ChangeRowView extends Backbone.View
  tagName: 'tr'
  template: JST['changes_row']

  events:
    "click .btn": "toggleChange"

  initialize: (options) ->
    @model = options.model
    @render()

  render: =>
    if @model.get('applied') then @$el.addClass('applied') else @$el.removeClass('applied') 
    if @model.getSpecies() 
      speciesName = @model.getSpecies().get('full_name')
      speciesListing = @model.getSpecies().get('current_listing')
      speciesAuthor = @model.getSpecies().get('author_year')
    else
      speciesName = 'Unknown species'
      speciesListing = 'Unlisted'
      speciesAuthor = ""
    @$el.html(@template(cid: @cid, change: @model, speciesName: speciesName, speciesListing: speciesListing, speciesAuthor: speciesAuthor))

  toggleChange: (e) ->
    console.log @model.get('change_type')
    @model.toggleChange()
    @render()

  onClose: ->
