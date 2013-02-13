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
    appliedChanges = @changeList.appliedChanges().length
    unappliedChanges = @changeList.models.length - appliedChanges
    @$el.html(@template(
      manualOutstandingChanges: @roundUp(@manualTimeRemaining/@taskTime)
      manualTimeRemaining: @secondsAsTime(@manualTimeRemaining)
      changesLeftToApply: unappliedChanges
      totalChanges: @changeList.models.length
      apiTimeRemaining: @secondsAsTime(unappliedChanges)
      appliedChanges: appliedChanges
      timeSaved: @secondsAsTime(appliedChanges*@taskTime - appliedChanges)
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

  roundDown:  (number) ->
    Math.round(number - 0.5)

  roundUp:  (number) ->
    Math.round(number + 0.5)

  secondsAsTime: (seconds)->
    times = {}
    secondsInMinute = 60
    secondsInHour = secondsInMinute*60
    secondsInWorkDay = secondsInHour*7.5
    times.days = @roundDown(seconds/secondsInWorkDay)
    times.hours = @roundDown((seconds-(times.days*secondsInWorkDay))/secondsInHour)
    times.minutes = @roundDown((seconds-((times.hours*secondsInHour)+(times.days*secondsInWorkDay)))/secondsInMinute)
    times.seconds = @roundDown(seconds-((times.minutes*secondsInMinute)+(times.hours*secondsInHour)+(times.days*secondsInWorkDay)))
    return times

  onClose: ->
    @stopListening(@changeList, 'sync', @render)
