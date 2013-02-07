window.JST ||= {}

window.JST['stats'] = _.template("""
  <ul class="stats">
    <li>
      <h4>Changes outstanding:</h4>
      <span class="value"><%= outstandingCount %></span>
    </li>
    <li>
      <h4>Changes merged:</h4>
      <span class="value"><%= appliedCount %></span>
    </li>
    <li>
      <h4>Time saved:</h4>
      <span class="value"><%= hoursSaved %> Hours</span>
    </li>
  </ul>
""")
