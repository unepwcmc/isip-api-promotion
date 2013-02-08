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
      <span class="value"><%= apiTimeRemaining %> seconds</span>
    </li>
    <li>
      <h4>WCMC API SAVED</h4>
      <span class="value"><%= '' %></span>
    </li>
  </ul>
""")
