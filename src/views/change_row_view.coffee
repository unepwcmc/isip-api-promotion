window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.ChangeRowView extends Backbone.View
  tagName: 'tr'

  events:
    "click .btn": "toggleChange"

  initialize: (options) ->
    @model = options.model
    @template = JST["changes_row_#{@model.get('change_type').toLowerCase()}"]
    @render()

  render: =>
    if @model.get('applied') then @$el.addClass('applied') else @$el.removeClass('applied') 
    if @model.getSpecies() 
      speciesName = speciesNameShort = @model.getSpecies().get('full_name')
      speciesListing = @model.getSpecies().get('current_listing')
      speciesAuthor = speciesAuthorShort = @model.getSpecies().get('author_year')

      if speciesName.length > 20
        speciesNameShort = speciesNameShort.slice(0, 17) + "..."

      if speciesAuthor? && speciesAuthor.length > 25
        speciesAuthorShort = speciesAuthorShort.slice(0, 22) + "..."
    else
      speciesName = 'Unknown species'
      speciesListing = 'Unlisted'
      speciesAuthor = ""

    @$el.html(@template(
      cid: @cid
      change: @model
      speciesName:
        long: speciesName
        short: speciesNameShort
      speciesListing: speciesListing
      speciesAuthor:
        long: speciesAuthor
        short: speciesAuthorShort
    ))

  toggleChange: (e) ->
    console.log @model.get('change_type')
    @model.toggleChange()
    @render()

  onClose: ->
