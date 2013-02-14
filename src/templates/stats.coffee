window.JST ||= {}

window.JST['stats'] = _.template("""
  <div class="col1">
    <h3>UNEP-WCMC API</h3>

    <h4>Changes to apply</h4>
    <div class="large-number-grid">
      <%= changesLeftToApply %>
      <span>Out Of <%= totalChanges %></span>
    </div>

    <h4>Estimated Time</h4>
    <div class="time-grid">
      <div><%= apiTimeRemaining.days %></div>
      <span class="hours"><%= apiTimeRemaining.hours %></span>
      <span class="mins"><%= apiTimeRemaining.minutes %></span>
    </div>
  </div>

  <div class="col2">
    <h3>Manual Update</h3>

    <h4>Changes to apply</h4>
    <div class="large-number-grid">
      <%= manualOutstandingChanges %>
      <span>Out Of <%= totalChanges %></span>
    </div>

    <h4>Estimated Time</h4>
    <div class="time-grid">
      <div><%= manualTimeRemaining.days %></div>
      <span class="hours"><%= manualTimeRemaining.hours %></span>
      <span class="mins"><%= manualTimeRemaining.minutes %></span>
    </div>
  </div>

  <div class="col3">
    <h3>The UNEP-WCMC API Saves</h3>
    <div class="time-grid time-saved">
      <div><%= timeSaved.days %></div>
      <span class="hours"><%= timeSaved.hours %></span>
      <span class="mins"><%= timeSaved.minutes %></span>
    </div>
  </div>
""")
