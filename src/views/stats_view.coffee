window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.StatsView extends Backbone.View
  template: JST['stats']

  initialize: (options) ->
    @changeList = options.changeList
    @listenTo(@changeList, 'sync', @resetManualTimer)
    @listenTo(@changeList, 'change', @render)
    @resetManualTimer()

  render: =>
    unappliedChanges = @changeList.models.length - @changeList.appliedChanges().length
    @$el.html(@template(
      manualOutstandingChanges: Math.round((@manualTimeRemaining/@taskTime)+0.49)
      manualTimeRemaining: @secondsAsTime(@manualTimeRemaining)
      changesLeftToApply: unappliedChanges
      apiTimeRemaining: unappliedChanges
    ))

  taskTime: 3600

  resetManualTimer: ->
    @manualTimeRemaining = @changeList.models.length*@taskTime
    @timeSpent = 0

    clearTimeout(@timer) if @timer?
    @timer = setTimeout(@updateTimers, 1000)

  updateTimers: =>
    @manualTimeRemaining = @manualTimeRemaining - 1 if @manualTimeRemaining > 0
    @timeSpent = @timeSpent + 1
    @render()
    
    @timer = setTimeout(@updateTimers, 1000)

  secondsAsTime: (seconds)->
    times = {}
    roundDown = (number) ->
      Math.round(number - 0.5)
    secondsInMinute = 60
    secondsInHour = secondsInMinute*60
    secondsInWorkDay = secondsInHour*7.5
    times.days = roundDown(seconds/secondsInWorkDay)
    times.hours = roundDown((seconds-(times.days*secondsInWorkDay))/secondsInHour)
    times.minutes = roundDown((seconds-((times.hours*secondsInHour)+(times.days*secondsInWorkDay)))/secondsInMinute)
    return times

  onClose: ->
    @stopListening(@changeList, 'sync', @render)
