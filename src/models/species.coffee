window.Backbone.Models || = {}

class window.Backbone.Models.Species extends Backbone.Model
  pendingChangeCount: ->
    ISIP.changeList.where(
      taxon_concept_id: @get('id')
      applied: false
    ).length
