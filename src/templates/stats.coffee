window.JST ||= {}

window.JST['stats'] = _.template("""
  <ul class="stats">
    <li>
      <h4>MANUAL UPDATE</h4>
      <h5>CHANGES TO APPLY</h5>
      <span class="value"><%= manualOutstandingChanges %></span>
      <h5>ESTIMATED TIME REMAINING</h5>
      <span class="value"><%= manualTimeRemaining.days %> days, <%= manualTimeRemaining.hours %> hours, <%= manualTimeRemaining.minutes %> minutes</span>
    </li>
    <li>
      <h4>WCMC API</h4>
      <h5>API CHANGES LEFT TO APPLY</h5>
      <span class="value"><%= changesLeftToApply %></span>
      <h5>ESTIMATED TIME REMAINING</h5>
      <span class="value"><%= apiTimeRemaining.minutes %> hours, <%= apiTimeRemaining.minutes %> minutes, <%= apiTimeRemaining.seconds %> seconds</span>
    </li>
    <li>
      <h4>WCMC API SAVED</h4>
      <p>Over <%= appliedChanges %> changes, you saved: </p>
      <span class="value"><%= timeSaved.hours %> hours, <%= timeSaved.minutes %> minutes</span>
    </li>
  </ul>
""")
